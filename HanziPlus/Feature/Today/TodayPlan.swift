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

        return (.study(fileName: SampleStudySets.travel.fileName, sectionID: nil), "Continue Travel words")
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
                    if days < 0 { return "Trip date has passed — keep phrases ready." }
                    if days == 0 { return "Your trip is today. Stay ready." }
                    return "\(days) day\(days == 1 ? "" : "s") until your trip"
                }
                return "Offline phrases for real situations"
            }()
            return TodayHeroContent(
                title: "Travel Toolkit",
                subtitle: countdown,
                buttonTitle: "Open Travel Toolkit",
                icon: "airplane",
                destination: .travelHub
            )

        case .learnChinese, .both:
            let session = lessonStore.ensureTodaySession(profile: profile, learnedStore: learnedStore)
            let set = SampleStudySets.studySet(fileName: session.fileName)
                ?? recommendedStudySet(for: profile)
            let count = session.wordCount

            switch lessonStore.status {
            case .complete:
                return TodayHeroContent(
                    title: "Today’s Lesson Complete",
                    subtitle: "Nice work — reinforce with Smart Review or explore Journey",
                    buttonTitle: "Start Smart Review",
                    icon: "checkmark.circle.fill",
                    destination: .smartReview(fileName: session.fileName)
                )
            case .inProgress:
                return TodayHeroContent(
                    title: "Continue Today’s Lesson",
                    subtitle: "\(set.title) · \(count) words",
                    buttonTitle: "Continue Lesson",
                    icon: "play.fill",
                    destination: .dailyLesson
                )
            case .notStarted:
                let subtitle = profile.primaryGoal == .both
                    ? "\(set.title) · \(count) words · Travel Toolkit stays one tap away"
                    : "\(set.title) · \(count) words"
                return TodayHeroContent(
                    title: "Start Today’s Lesson",
                    subtitle: subtitle,
                    buttonTitle: "Start Today’s Lesson",
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
            let size = "\(lessonSession.wordCount) words"
            switch lessonStore.status {
            case .notStarted:
                return "\(lessonSet.title) · \(size)"
            case .inProgress:
                let phase = lessonSession.phase.rawValue.capitalized
                return "\(lessonSet.title) · \(size) · \(phase)"
            case .complete:
                return "\(lessonSet.title) · \(size) · Done"
            }
        }()

        var actions: [TodayPlanAction] = []

        switch profile.primaryGoal {
        case .learnChinese:
            actions.append(
                TodayPlanAction(
                    id: "learn",
                    title: "Learn",
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
                    title: "Learn",
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
                    title: "Travel Toolkit",
                    detail: "Offline phrases for real trips",
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
                        title: "Learn",
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
                        title: "Learn",
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
                    title: "Travel Toolkit",
                    detail: "Essentials, categories, and show-to-local",
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
                title: "Review",
                detail: "Smart Review · reinforce weak words",
                icon: "arrow.triangle.2.circlepath",
                tintName: "purple",
                destination: .smartReview(fileName: reviewSetFileName)
            )
        )
        actions.append(
            TodayPlanAction(
                id: "explore",
                title: "Explore",
                detail: profile.primaryGoal.includesTravel
                    ? "China Journey map"
                    : "Visit a city on your Journey map",
                icon: "globe.asia.australia.fill",
                tintName: "orange",
                destination: .journey
            )
        )

        return actions
    }
}
