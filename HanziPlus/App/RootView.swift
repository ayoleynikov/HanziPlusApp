//
//  RootView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct RootView: View {

    @Environment(UserProfileStore.self) private var profileStore

    var body: some View {
        Group {
            if profileStore.needsOnboarding {
                OnboardingView()
                    .transition(.opacity)
            } else {
                MainTabView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.28), value: profileStore.needsOnboarding)
    }
}

#Preview {
    RootView()
        .environmentObject(FavoritesStore())
        .environment(StatisticsStore())
        .environment(WordCatalog())
        .environment(HistoryStore())
        .environment(LearnedWordsStore())
        .environment(StudySessionStore())
        .environment(GameScoreStore())
        .environment(SmartReviewStore())
        .environment(DailyChallengeStore())
        .environment(AchievementStore())
        .environment(JourneyStore())
        .environment(AppTabRouter())
        .environment(GameSessionStore())
        .environment(GamesDailyProgressStore())
        .environment(GamesPlayHistoryStore())
        .environment(UserProfileStore())
}
