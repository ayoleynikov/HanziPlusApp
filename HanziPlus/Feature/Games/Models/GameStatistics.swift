//
//  GameStatistics.swift
//  HanziPlus
//

import Foundation

struct GameStatistics: Codable, Equatable {
    var gamesPlayed: Int = 0
    var bestScore: Int = 0
    var totalCorrect: Int = 0
    var totalWrong: Int = 0
    var totalTimeSeconds: Int = 0
    var longestStreak: Int = 0
    var xpEarned: Int = 0

    var averageAccuracy: Int {
        let total = totalCorrect + totalWrong
        guard total > 0 else { return 0 }
        return Int(Double(totalCorrect) / Double(total) * 100)
    }

    var averageTime: Int {
        guard gamesPlayed > 0 else { return 0 }
        return totalTimeSeconds / gamesPlayed
    }
}

extension GameDifficulty {

    var questionCount: Int {
        switch self {
        case .easy: 8
        case .medium: 12
        case .hard: 16
        }
    }

    var optionCount: Int {
        switch self {
        case .easy: 4
        case .medium: 6
        case .hard: 8
        }
    }

    var memoryPairCount: Int {
        switch self {
        case .easy: 6
        case .medium: 8
        case .hard: 10
        }
    }

    var gridDimension: Int {
        switch self {
        case .easy: 2
        case .medium: 3
        case .hard: 4
        }
    }
}

extension GameResult {

    static func score(
        correct: Int,
        accuracy: Int,
        comboPeak: Int,
        gameKind: GameKind
    ) -> Int {
        let base = correct * 100 + max(0, accuracy - 50)
        let comboBonus = comboPeak * 25
        let kindBonus: Int = switch gameKind {
        case .speedChallenge: 50
        case .sentenceBuilder: 80
        case .hanziMemory: 60
        case .typingChallenge: 70
        case .dailyChallenge: 100
        default: 0
        }
        return base + comboBonus + kindBonus
    }

    static func xp(
        correct: Int,
        comboPeak: Int,
        accuracy: Int,
        streak: Int = 0,
        gameKind: GameKind
    ) -> Int {
        let base = correct * 10
        let comboBonus = comboPeak * 5
        let streakBonus = streak * 8
        let accuracyBonus = accuracy >= 90 ? 50 : (accuracy >= 70 ? 25 : 0)
        let gameMultiplier: Int = switch gameKind {
        case .speedChallenge: 2
        case .sentenceBuilder: 3
        case .typingChallenge: 2
        case .dailyChallenge: 3
        case .smartReview: 2
        default: 1
        }
        return (base + comboBonus + streakBonus + accuracyBonus) * gameMultiplier
    }
}
