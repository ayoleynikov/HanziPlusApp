//
//  AchievementStore.swift
//  HanziPlus
//

import Foundation
import Observation

struct Achievement: Identifiable, Equatable {
    let id: String
    let title: String
    let description: String
    let icon: String
    var isUnlocked: Bool
}

@Observable
final class AchievementStore {

    private let defaults = UserDefaults.standard
    private let unlockedKey = "achievements.unlocked"

    private(set) var unlockedIDs: Set<String> = []

    init() {
        unlockedIDs = Set(defaults.stringArray(forKey: unlockedKey) ?? [])
    }

    var achievements: [Achievement] {
        catalog.map { item in
            Achievement(
                id: item.id,
                title: item.title,
                description: item.description,
                icon: item.icon,
                isUnlocked: unlockedIDs.contains(item.id)
            )
        }
    }

    func evaluate(
        result: GameResult,
        totalXP: Int,
        learnedCount: Int,
        smartReviewStore: SmartReviewStore?
    ) {
        unlock("first_game")
        if result.correctCount + result.wrongCount > 0 {
            unlock("first_game")
        }

        let totalCorrect = defaults.integer(forKey: "achievements.totalCorrect") + result.correctCount
        defaults.set(totalCorrect, forKey: "achievements.totalCorrect")
        if totalCorrect >= 100 { unlock("100_correct") }

        if totalXP >= 1000 { unlock("1000_xp") }
        if learnedCount >= 100 { unlock("100_learned") }
        if result.gameKind == .listeningQuiz && result.accuracy == 100 { unlock("perfect_listening") }
        if result.gameKind == .typingChallenge && result.accuracy >= 90 { unlock("typing_expert") }
        if result.gameKind == .hanziMemory && result.accuracy >= 85 { unlock("memory_champion") }
        if result.studySetFileName == "hsk1" && result.accuracy == 100 { unlock("master_hsk1") }
    }

    func unlockDailyStreak(_ days: Int) {
        if days >= 7 { unlock("7_day_streak") }
    }

    func unlockJourneyProgress(citiesCompleted: Int) {
        if citiesCompleted >= 2 { unlock("journey_first_city") }
    }

    func unlockJourneyComplete() {
        unlock("journey_complete")
    }

    private func unlock(_ id: String) {
        guard !unlockedIDs.contains(id) else { return }
        unlockedIDs.insert(id)
        defaults.set(Array(unlockedIDs), forKey: unlockedKey)
    }

    private var catalog: [(id: String, title: String, description: String, icon: String)] {
        [
            ("first_game", "First Game", "Complete your first game.", "gamecontroller.fill"),
            ("100_correct", "100 Correct Answers", "Answer 100 questions correctly.", "checkmark.circle.fill"),
            ("7_day_streak", "7-Day Streak", "Complete daily challenges 7 days in a row.", "flame.fill"),
            ("100_learned", "100 Learned Words", "Mark 100 words as learned.", "graduationcap.fill"),
            ("1000_xp", "1000 XP", "Earn 1000 XP across all games.", "sparkles"),
            ("master_hsk1", "Master of HSK 1", "Perfect score on an HSK 1 game.", "1.circle.fill"),
            ("perfect_listening", "Perfect Listening", "100% accuracy in Listening Quiz.", "ear.fill"),
            ("typing_expert", "Typing Expert", "90%+ accuracy in Typing Challenge.", "keyboard.fill"),
            ("memory_champion", "Memory Champion", "85%+ accuracy in Hanzi Memory.", "square.grid.2x2.fill"),
            ("journey_first_city", "First City", "Complete your first journey milestone.", "globe.asia.australia.fill"),
            ("journey_complete", "China Explorer", "Complete the full HanziPlus journey.", "map.fill")
        ]
    }
}
