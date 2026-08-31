//
//  MainTabView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//
import SwiftUI

struct MainTabView: View {

    @Environment(AppTabRouter.self) private var tabRouter
    @Environment(LanguageSettingsStore.self) private var languageStore

    var body: some View {
        @Bindable var tabRouter = tabRouter
        let _ = languageStore.refreshToken

        TabView(selection: $tabRouter.selectedTab) {

            TodayView()
                .tag(AppTab.today)
                .tabItem {
                    Label(L10n.string( "tab.today"), systemImage: "sun.max.fill")
                }

            StudySetsView()
                .tag(AppTab.learn)
                .tabItem {
                    Label(L10n.string( "tab.learn"), systemImage: "book.fill")
                }
                .accessibilityIdentifier("tab_learn")

            TravelTabView()
                .tag(AppTab.travel)
                .tabItem {
                    Label(L10n.string( "tab.travel"), systemImage: "airplane")
                }

            GamesHubView()
                .tag(AppTab.games)
                .tabItem {
                    Label(L10n.string( "tab.games"), systemImage: "gamecontroller.fill")
                }

        }
    }
}

#Preview {
    MainTabView()
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
        .environment(UserProfileStore())
        .environment(GamesDailyProgressStore())
        .environment(LanguageSettingsStore())
}
