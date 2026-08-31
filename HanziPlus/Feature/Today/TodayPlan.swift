//
//  TodayPlan.swift
//  HanziPlus
//

import Foundation

enum TodayDestination: Hashable {
    case study(fileName: String, sectionID: String?)
    case smartReview(fileName: String)
    case dailyLesson
    case pathCourse
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
                L10n.string("today.continue.named \(section.localizedTitle)")
            )
        }

        if let set = SampleStudySets.studySet(fileName: key) {
            return (.study(fileName: set.fileName, sectionID: nil), L10n.string("today.continue.named \(set.localizedTitle)"))
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
                L10n.string("today.continue.named \(section.localizedTitle)")
            )
        }

        return (.study(fileName: SampleStudySets.travel.fileName, sectionID: nil), L10n.string( "today.continue.travel_words"))
    }

    static func hero(
        profile: UserProfile,
        sessionStore: StudySessionStore,
        lessonSession: DailyLessonSession?,
        lessonStatus: DailyLessonStatus
    ) -> TodayHeroContent {
        switch profile.primaryGoal {
        case .travelToChina:
            let countdown: String = {
                if let days = profile.daysUntilTravel {
                    if days < 0 { return L10n.string( "today.hero.trip_passed") }
                    if days == 0 { return L10n.string( "today.hero.trip_today") }
                    return L10n.daysUntilTrip(days)
                }
                return L10n.string( "today.hero.offline_phrases")
            }()
            return TodayHeroContent(
                title: L10n.string( "today.hero.travel_toolkit"),
                subtitle: countdown,
                buttonTitle: L10n.string( "today.hero.open_travel"),
                icon: "airplane",
                destination: .travelHub
            )

        case .learnChinese, .both:
            let context = lessonContext(profile: profile, lessonSession: lessonSession)
            let countLabel = lessonSession == nil
                ? L10n.string("lesson.preparing")
                : L10n.words(context.wordCount)

            switch lessonSession == nil ? .notStarted : lessonStatus {
            case .complete:
                return TodayHeroContent(
                    title: L10n.string( "today.hero.lesson_complete"),
                    subtitle: L10n.string( "today.hero.lesson_complete.subtitle"),
                    buttonTitle: L10n.string( "today.hero.start_smart_review"),
                    icon: "checkmark.circle.fill",
                    destination: .smartReview(fileName: context.fileName)
                )
            case .inProgress:
                return TodayHeroContent(
                    title: L10n.string( "today.hero.continue_lesson"),
                    subtitle: "\(context.set.localizedTitle) · \(countLabel)",
                    buttonTitle: L10n.string( "today.hero.continue_lesson_cta"),
                    icon: "play.fill",
                    destination: .dailyLesson
                )
            case .notStarted:
                let subtitle = profile.primaryGoal == .both
                    ? "\(context.set.localizedTitle) · \(countLabel) · \(L10n.string( "today.hero.subtitle_both_suffix"))"
                    : "\(context.set.localizedTitle) · \(countLabel)"
                return TodayHeroContent(
                    title: L10n.string( "today.hero.start_lesson"),
                    subtitle: subtitle,
                    buttonTitle: L10n.string( "today.hero.start_lesson"),
                    icon: "sun.max.fill",
                    destination: .dailyLesson
                )
            }
        }
    }

    static func planActions(
        profile: UserProfile,
        sessionStore: StudySessionStore,
        lessonSession: DailyLessonSession?,
        lessonStatus: DailyLessonStatus,
        weakWordsCount: Int = 0,
        journeyCitiesCompleted: Int = 0,
        journeyCitiesTotal: Int = JourneyCityCatalog.all.count
    ) -> [TodayPlanAction] {
        let context = lessonContext(profile: profile, lessonSession: lessonSession)
        let effectiveStatus: DailyLessonStatus = lessonSession?.completed == true ? .complete : lessonStatus
        let lessonComplete = effectiveStatus == .complete
        let lessonDetail: String = {
            let size = lessonSession == nil
                ? L10n.string("lesson.preparing")
                : L10n.words(context.wordCount)
            let setTitle = context.set.localizedTitle
            switch effectiveStatus {
            case .notStarted:
                return "\(setTitle) · \(size)"
            case .inProgress:
                guard let lessonSession else { return "\(setTitle) · \(size)" }
                let phase = L10n.dynamic("lesson.phase.\(lessonSession.phase.rawValue)")
                return "\(setTitle) · \(size) · \(phase)"
            case .complete:
                return "\(setTitle) · \(size) · \(L10n.string( "common.done"))"
            }
        }()

        var actions: [TodayPlanAction] = []

        switch profile.primaryGoal {
        case .learnChinese:
            actions.append(
                TodayPlanAction(
                    id: "learn",
                    title: L10n.string( "today.action.learn"),
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
                    title: L10n.string( "today.action.learn"),
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
                    title: L10n.string( "today.action.travel_toolkit"),
                    detail: L10n.string( "today.action.travel_detail_both"),
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
                        title: L10n.string( "today.action.learn"),
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
                        title: L10n.string( "today.action.learn"),
                        detail: L10n.string("today.plan.travel_lesson_detail \(context.wordCount)"),
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
                    title: L10n.string( "today.action.travel_toolkit"),
                    detail: L10n.string( "today.action.travel_detail_travel"),
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
            return context.fileName
        }()

        let reviewDetail: String = {
            if weakWordsCount > 0 {
                return "\(L10n.string("today.action.review")) · \(L10n.words(weakWordsCount))"
            }
            return L10n.string("today.action.review_detail")
        }()

        actions.append(
            TodayPlanAction(
                id: "review",
                title: L10n.string( "today.action.review"),
                detail: reviewDetail,
                icon: "arrow.triangle.2.circlepath",
                tintName: "purple",
                destination: .smartReview(fileName: reviewSetFileName)
            )
        )

        let exploreDetail = L10n.string(
            "journey.cities_explored \(journeyCitiesCompleted) \(journeyCitiesTotal)"
        )
        actions.append(
            TodayPlanAction(
                id: "explore",
                title: L10n.string( "today.action.explore"),
                detail: exploreDetail,
                icon: "globe.asia.australia.fill",
                tintName: "orange",
                destination: .journey
            )
        )

        return actions
    }

    private static func lessonContext(
        profile: UserProfile,
        lessonSession: DailyLessonSession?
    ) -> (fileName: String, wordCount: Int, set: StudySet) {
        let fileName = lessonSession?.fileName ?? DailyLessonPlanner.recommendedFileName(for: profile)
        let set = SampleStudySets.studySet(fileName: fileName) ?? recommendedStudySet(for: profile)
        let wordCount = lessonSession?.wordCount ?? DailyLessonPlanner.targetWordCount(for: profile)
        return (fileName, wordCount, set)
    }
}
