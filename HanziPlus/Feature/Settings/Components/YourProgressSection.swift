//
//  YourProgressSection.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct YourProgressSection: View {

    @Environment(DailyLessonStore.self) private var lessonStore
    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(SmartReviewStore.self) private var smartReviewStore
    @Environment(UserProfileStore.self) private var profileStore
    @Environment(JourneyStore.self) private var journeyStore

    private var profile: UserProfile { profileStore.profile }

    private var lessonStatusText: String {
        switch lessonStore.status {
        case .complete:
            return L10n.string("common.done")
        case .inProgress:
            return L10n.string("today.progress.lesson_active")
        case .notStarted:
            return L10n.string("today.progress.lesson_pending")
        }
    }

    private var weakWordsCount: Int {
        AppDailyProgress.weakWordsCount(
            profile: profile,
            smartReview: smartReviewStore,
            learnedStore: learnedStore
        )
    }

    var body: some View {
        Group {
            LabeledContent {
                Text(lessonStatusText)
                    .fontWeight(.semibold)
            } label: {
                Label(L10n.string("today.action.learn"), systemImage: "text.book.closed.fill")
            }

            LabeledContent {
                Text("\(learnedStore.learnedIDs.count)")
                    .fontWeight(.semibold)
            } label: {
                Label(L10n.string("study.learned_words.title"), systemImage: "checkmark.circle.fill")
            }

            LabeledContent {
                Text("\(weakWordsCount)")
                    .fontWeight(.semibold)
            } label: {
                Label(L10n.string("today.action.review"), systemImage: "arrow.triangle.2.circlepath")
            }

            LabeledContent {
                Text(
                    L10n.string(
                        "journey.cities_explored \(journeyStore.collectedSouvenirs.count) \(JourneyCityCatalog.all.count)"
                    )
                )
                .fontWeight(.semibold)
            } label: {
                Label(L10n.string("journey.passport.title"), systemImage: "globe.asia.australia.fill")
            }
        }
    }
}

#Preview {
    List {
        Section("Your Progress") {
            YourProgressSection()
        }
    }
    .environment(DailyLessonStore())
    .environment(LearnedWordsStore())
    .environment(SmartReviewStore())
    .environment(UserProfileStore())
    .environment(JourneyStore())
}
