//
//  HanziPlusApp.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

@main
struct HanziPlusApp: App {

    @StateObject private var favoritesStore = FavoritesStore()
    @State private var statisticsStore = StatisticsStore()
    @State private var wordCatalog = WordCatalog()
    @State private var historyStore = HistoryStore()
    @State private var learnedWordsStore = LearnedWordsStore()
    @State private var studySessionStore = StudySessionStore()
    @State private var gameScoreStore = GameScoreStore()
    @State private var smartReviewStore = SmartReviewStore()
    @State private var dailyChallengeStore = DailyChallengeStore()
    @State private var achievementStore = AchievementStore()
    @State private var journeyStore = JourneyStore()
    @State private var tabRouter = AppTabRouter()
    @State private var gameSessionStore = GameSessionStore()
    @State private var gamesDailyProgressStore = GamesDailyProgressStore()
    @State private var gamesPlayHistoryStore = GamesPlayHistoryStore()
    @State private var userProfileStore = UserProfileStore()
    @State private var travelPhraseStore = TravelPhraseStore()
    @State private var dailyLessonStore = DailyLessonStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(favoritesStore)
                .environment(statisticsStore)
                .environment(wordCatalog)
                .environment(historyStore)
                .environment(learnedWordsStore)
                .environment(studySessionStore)
                .environment(gameScoreStore)
                .environment(smartReviewStore)
                .environment(dailyChallengeStore)
                .environment(achievementStore)
                .environment(journeyStore)
                .environment(tabRouter)
                .environment(gameSessionStore)
                .environment(gamesDailyProgressStore)
                .environment(gamesPlayHistoryStore)
                .environment(userProfileStore)
                .environment(travelPhraseStore)
                .environment(dailyLessonStore)
        }
    }
}
