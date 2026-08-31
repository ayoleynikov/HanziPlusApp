//
//  RootView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct RootView: View {

    @Environment(UserProfileStore.self) private var profileStore
    @Environment(LanguageSettingsStore.self) private var languageStore
    @Environment(DailyLessonStore.self) private var lessonStore
    @Environment(LearnedWordsStore.self) private var learnedStore

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
        .environment(\.locale, languageStore.locale)
        .environment(\.contentLanguage, languageStore.contentLanguage)
        .task(id: dailyLessonTaskID) {
            guard !profileStore.needsOnboarding else { return }
            lessonStore.ensureTodaySession(
                profile: profileStore.profile,
                learnedStore: learnedStore
            )
        }
    }

    private var dailyLessonTaskID: String {
        let profile = profileStore.profile
        let fileName = DailyLessonPlanner.recommendedFileName(for: profile)
        return "\(DailyLessonPlanner.dateKey())|\(DailyLessonPlanner.profileSignature(profile: profile, fileName: fileName))"
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
        .environment(LanguageSettingsStore())
        .environment(DailyLessonStore())
}
