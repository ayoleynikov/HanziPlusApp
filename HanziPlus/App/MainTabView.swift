//
//  MainTabView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//
import SwiftUI

struct MainTabView: View {

    @Environment(AppTabRouter.self) private var tabRouter

    var body: some View {
        @Bindable var tabRouter = tabRouter

        TabView(selection: $tabRouter.selectedTab) {

            TodayView()
                .tag(AppTab.today)
                .tabItem {
                    Label("Today", systemImage: "sun.max.fill")
                }

            StudySetsView()
                .tag(AppTab.learn)
                .tabItem {
                    Label("Learn", systemImage: "book.fill")
                }

            TravelTabView()
                .tag(AppTab.travel)
                .tabItem {
                    Label("Travel", systemImage: "airplane")
                }

            GamesView()
                .tag(AppTab.games)
                .tabItem {
                    Label("Games", systemImage: "gamecontroller.fill")
                }

            JourneyView()
                .tag(AppTab.journey)
                .tabItem {
                    Label("Journey", systemImage: "globe.asia.australia.fill")
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
}
