//
//  TodayPlan.swift
//  HanziPlus
//

import Foundation

enum TodayDestination: Hashable {
    case study(fileName: String, sectionID: String?)
    case smartReview(fileName: String)
    case dailyLesson
    case travelHub
    case travelEssentials
    case journey
    case learnTab
    case gamesTab
}

struct TodayHeroContent: Equatable {
    let title: String
    let subtitle: String
    let buttonTitle: String
    let icon: String
    let destination: TodayDestination
}

struct TodayPlanAction: Identifiable, Equatable {
    let id: String
    let title: String
    let detail: String
    let icon: String
    let tintName: String
    let destination: TodayDestination
    var isCompleted: Bool = false
}

enum TodayPlanBuilder {

    static func recommendedStudySet(for profile: UserProfile) -> StudySet {
        profile.chineseLevel.recommendedStudySet
    }

    static func lessonWordCount(for profile: UserProfile) -> Int {
        profile.dailyMinutes.lessonWordCount
    }

    static func continueDestination(
        profile: UserProfile,
        sessionStore: StudySessionStore
    ) -> (destination: TodayDestination, label: String)? {
        guard let key = sessionStore.lastActiveFileName,
              sessionStore.session(for: key) != nil
        else { return nil }

        // Travel goal: only continue travel study sessions as the Learn task.
        if profile.primaryGoal == .travelToChina {
            let isTravelSession = key == SampleStudySets.travel.fileName
                || key.hasPrefix("\(SampleStudySets.travel.fileName):")
            guard isTravelSession else { return nil }
        }

        if let parsed = SectionedVocabulary.parseSessionKey(key),
           let set = SampleStudySets.studySet(fileName: parsed.fileName),
           let section = StudySetCatalog.section(fileName: parsed.fileName, id: parsed.sectionID) {
            return (
                .study(fileName: set.fileName, sectionID: section.id),
                "Continue \(section.title)"
            )
        }

        if let set = SampleStudySets.studySet(fileName: key) {
            return (.study(fileName: set.fileName, sectionID: nil), "Continue \(set.title)")
        }

        return nil
    }

    static func continueTravelDestination(
        sessionStore: StudySessionStore
    ) -> (destination: TodayDestination, label: String)? {
        guard let key = sessionStore.lastActiveFileName,
              sessionStore.session(for: key) != nil
        else { return nil }

        let isTravelSession = key == SampleStudySets.travel.fileName
            || key.hasPrefix("\(SampleStudySets.travel.fileName):")
        guard isTravelSession else { return nil }

        if let parsed = SectionedVocabulary.parseSessionKey(key),
           let section = StudySetCatalog.section(fileName: parsed.fileName, id: parsed.sectionID) {
            return (
                .study(fileName: SampleStudySets.travel.fileName, sectionID: section.id),
                "Continue \(section.title)"
            )
        }

        return (.study(fileName: SampleStudySets.travel.fileName, sectionID: nil), String(localized: "today.continue.travel_words"))
    }

    static func hero(
        profile: UserProfile,
        sessionStore: StudySessionStore,
        lessonStore: DailyLessonStore,
        learnedStore: LearnedWordsStore
    ) -> TodayHeroContent {
        switch profile.primaryGoal {
        case .travelToChina:
            let countdown: String = {
                if let days = profile.daysUntilTravel {
                    if days < 0 { return String(localized: "today.hero.trip_passed") }
                    if days == 0 { return String(localized: "today.hero.trip_today") }
                    return L10n.daysUntilTrip(days)
                }
                return String(localized: "today.hero.offline_phrases")
            }()
            return TodayHeroContent(
                title: String(localized: "today.hero.travel_toolkit"),
                subtitle: countdown,
                buttonTitle: String(localized: "today.hero.open_travel"),
                icon: "airplane",
                destination: .travelHub
            )

        case .learnChinese, .both:
            let session = lessonStore.ensureTodaySession(profile: profile, learnedStore: learnedStore)
            let set = SampleStudySets.studySet(fileName: session.fileName)
                ?? recommendedStudySet(for: profile)
            let countLabel = L10n.words(session.wordCount)
            let setTitle = set.localizedTitle

            switch lessonStore.status {
            case .complete:
                return TodayHeroContent(
                    title: String(localized: "today.hero.lesson_complete"),
                    subtitle: String(localized: "today.hero.lesson_complete.subtitle"),
                    buttonTitle: String(localized: "today.hero.start_smart_review"),
                    icon: "checkmark.circle.fill",
                    destination: .smartReview(fileName: session.fileName)
                )
            case .inProgress:
                return TodayHeroContent(
                    title: String(localized: "today.hero.continue_lesson"),
                    subtitle: "\(setTitle) · \(countLabel)",
                    buttonTitle: String(localized: "today.hero.continue_lesson_cta"),
                    icon: "play.fill",
                    destination: .dailyLesson
                )
            case .notStarted:
                let subtitle = profile.primaryGoal == .both
                    ? "\(setTitle) · \(countLabel) · \(String(localized: "today.hero.subtitle_both_suffix"))"
                    : "\(setTitle) · \(countLabel)"
                return TodayHeroContent(
                    title: String(localized: "today.hero.start_lesson"),
                    subtitle: subtitle,
                    buttonTitle: String(localized: "today.hero.start_lesson"),
                    icon: "sun.max.fill",
                    destination: .dailyLesson
                )
            }
        }
    }

    static func planActions(
        profile: UserProfile,
        sessionStore: StudySessionStore,
        lessonStore: DailyLessonStore,
        learnedStore: LearnedWordsStore
    ) -> [TodayPlanAction] {
        let lessonSession = lessonStore.ensureTodaySession(profile: profile, learnedStore: learnedStore)
        let lessonSet = SampleStudySets.studySet(fileName: lessonSession.fileName)
            ?? recommendedStudySet(for: profile)
        let lessonComplete = lessonStore.status == .complete
        let lessonDetail: String = {
            let size = L10n.words(lessonSession.wordCount)
            let setTitle = lessonSet.localizedTitle
            switch lessonStore.status {
            case .notStarted:
                return "\(setTitle) · \(size)"
            case .inProgress:
                let phase = String(localized: String.LocalizationValue("lesson.phase.\(lessonSession.phase.rawValue == "reviewMistakes" ? "review_mistakes" : lessonSession.phase.rawValue)"))
                return "\(setTitle) · \(size) · \(phase)"
            case .complete:
                return "\(setTitle) · \(size) · \(String(localized: "common.done"))"
            }
        }()

        var actions: [TodayPlanAction] = []

        switch profile.primaryGoal {
        case .learnChinese:
            actions.append(
                TodayPlanAction(
                    id: "learn",
                    title: String(localized: "today.action.learn"),
                    detail: lessonDetail,
                    icon: "text.book.closed.fill",
                    tintName: "blue",
                    destination: .dailyLesson,
                    isCompleted: lessonComplete
                )
            )

        case .both:
            actions.append(
                TodayPlanAction(
                    id: "learn",
                    title: String(localized: "today.action.learn"),
                    detail: lessonDetail,
                    icon: "text.book.closed.fill",
                    tintName: "blue",
                    destination: .dailyLesson,
                    isCompleted: lessonComplete
                )
            )
            actions.append(
                TodayPlanAction(
                    id: "travel",
                    title: String(localized: "today.action.travel_toolkit"),
                    detail: String(localized: "today.action.travel_detail_both"),
                    icon: "airplane",
                    tintName: "orange",
                    destination: .travelHub
                )
            )

        case .travelToChina:
            if let travelContinue = continueTravelDestination(sessionStore: sessionStore) {
                actions.append(
                    TodayPlanAction(
                        id: "learn",
                        title: String(localized: "today.action.learn"),
                        detail: travelContinue.label,
                        icon: "text.book.closed.fill",
                        tintName: "blue",
                        destination: travelContinue.destination
                    )
                )
            } else {
                actions.append(
                    TodayPlanAction(
                        id: "learn",
                        title: String(localized: "today.action.learn"),
                        detail: "Travel words · \(lessonSession.wordCount) words · guided lesson",
                        icon: "text.book.closed.fill",
                        tintName: "blue",
                        destination: .dailyLesson,
                        isCompleted: lessonComplete
                    )
                )
            }
            actions.append(
                TodayPlanAction(
                    id: "travel",
                    title: String(localized: "today.action.travel_toolkit"),
                    detail: String(localized: "today.action.travel_detail_travel"),
                    icon: "airplane",
                    tintName: "orange",
                    destination: .travelHub
                )
            )
        }

        let reviewSetFileName: String = {
            if profile.primaryGoal == .travelToChina {
                return SampleStudySets.travel.fileName
            }
            return lessonSession.fileName
        }()

        actions.append(
            TodayPlanAction(
                id: "review",
                title: String(localized: "today.action.review"),
                detail: String(localized: "today.action.review_detail"),
                icon: "arrow.triangle.2.circlepath",
                tintName: "purple",
                destination: .smartReview(fileName: reviewSetFileName)
            )
        )
        actions.append(
            TodayPlanAction(
                id: "explore",
                title: String(localized: "today.action.explore"),
                detail: profile.primaryGoal.includesTravel
                    ? String(localized: "today.action.explore_travel")
                    : String(localized: "today.action.explore_learn"),
                icon: "globe.asia.australia.fill",
                tintName: "orange",
                destination: .journey
            )
        )

        return actions
    }
}
