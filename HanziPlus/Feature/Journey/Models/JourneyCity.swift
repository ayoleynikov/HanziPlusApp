//
//  JourneyCity.swift
//  HanziPlus
//

import SwiftUI

struct JourneyCity: Identifiable, Equatable {
    let id: String
    let name: String
    let emoji: String
    let province: String
    let population: String
    let introduction: String
    let famousFor: String
    let bestSeason: String
    let localFood: String
    let culturalFact: String
    let localAchievement: String
    let souvenirEmoji: String
    let souvenirName: String
    let travelCollectible: String
    let theme: JourneyColorTheme
    let facts: [JourneyFact]
    let attractions: [JourneyAttraction]
    let vocabulary: [JourneyVocabularyWord]
    let miniActivity: JourneyMiniActivity
    let requirements: CityRequirements
}

struct JourneyProgress: Equatable {
    let learnedWords: Int
    let totalXP: Int
    let gamesPlayed: Int
    let accuracy: Int
    let hsk1Learned: Int
    let hsk1Total: Int
    let hsk2Learned: Int
    let hsk2Total: Int
    let dailyStreak: Int

    var hsk1Complete: Bool { hsk1Total > 0 && hsk1Learned >= hsk1Total }
    var hsk2Complete: Bool { hsk2Total > 0 && hsk2Learned >= hsk2Total }

    static func current(
        catalog: WordCatalog,
        learnedStore: LearnedWordsStore,
        gameScoreStore: GameScoreStore,
        statisticsStore: StatisticsStore,
        dailyChallengeStore: DailyChallengeStore
    ) -> JourneyProgress {
        let learned = SampleStudySets.all.reduce(0) { $0 + learnedStore.learnedCount(for: $1.fileName) }

        return JourneyProgress(
            learnedWords: learned,
            totalXP: gameScoreStore.totalXPAllGames(),
            gamesPlayed: statisticsStore.quizzesCompleted,
            accuracy: statisticsStore.accuracy,
            hsk1Learned: learnedStore.learnedCount(for: "hsk1"),
            hsk1Total: catalog.wordCount(for: "hsk1"),
            hsk2Learned: learnedStore.learnedCount(for: "hsk2"),
            hsk2Total: catalog.wordCount(for: "hsk2"),
            dailyStreak: dailyChallengeStore.streakDays
        )
    }
}

struct CityCompletionRecord: Codable, Equatable {
    let cityID: String
    let completedAt: Date
    let completionPercent: Int
}
