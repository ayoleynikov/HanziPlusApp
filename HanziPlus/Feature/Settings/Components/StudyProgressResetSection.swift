//
//  StudyProgressResetSection.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct StudyProgressResetSection: View {

    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(StudySessionStore.self) private var sessionStore
    @Environment(SmartReviewStore.self) private var smartReviewStore
    @Environment(StatisticsStore.self) private var statisticsStore
    @Environment(PathCourseStore.self) private var pathStore
    @Environment(JourneyStore.self) private var journeyStore
    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(GamesDailyProgressStore.self) private var dailyProgressStore
    @Environment(DailyChallengeStore.self) private var dailyChallengeStore
    @Environment(DailyLessonStore.self) private var lessonStore
    @Environment(TravelPhraseStore.self) private var phraseStore
    @Environment(AchievementStore.self) private var achievementStore
    @Environment(GamesPlayHistoryStore.self) private var playHistoryStore
    @EnvironmentObject private var favoritesStore: FavoritesStore

    @State private var showsResetConfirmation = false

    var body: some View {
        Button(role: .destructive) {
            showsResetConfirmation = true
        } label: {
            Text(l10n: "settings.reset.all_progress")
        }
        .alert(
            L10n.string("settings.reset.all_alert_title"),
            isPresented: $showsResetConfirmation
        ) {
            Button(L10n.string("common.cancel"), role: .cancel) {}
            Button(L10n.string("common.reset"), role: .destructive) {
                AppProgressReset.resetEverything(
                    learnedStore: learnedStore,
                    sessionStore: sessionStore,
                    smartReviewStore: smartReviewStore,
                    statisticsStore: statisticsStore,
                    pathStore: pathStore,
                    journeyStore: journeyStore,
                    scoreStore: scoreStore,
                    dailyProgressStore: dailyProgressStore,
                    dailyChallengeStore: dailyChallengeStore,
                    lessonStore: lessonStore,
                    phraseStore: phraseStore,
                    achievementStore: achievementStore,
                    playHistoryStore: playHistoryStore,
                    favoritesStore: favoritesStore
                )
                HapticService.light()
            }
        } message: {
            Text(l10n: "settings.reset.all_alert_body")
        }
    }
}

#Preview {
    List {
        Section("Reset") {
            StudyProgressResetSection()
        }
    }
    .environment(LearnedWordsStore())
    .environment(StudySessionStore())
    .environment(SmartReviewStore())
    .environment(StatisticsStore())
    .environment(PathCourseStore())
    .environment(JourneyStore())
    .environment(GameScoreStore())
    .environment(GamesDailyProgressStore())
    .environment(DailyChallengeStore())
    .environment(DailyLessonStore())
    .environment(TravelPhraseStore())
    .environment(AchievementStore())
    .environment(GamesPlayHistoryStore())
    .environmentObject(FavoritesStore())
}
