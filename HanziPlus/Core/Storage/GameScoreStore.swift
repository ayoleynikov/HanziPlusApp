//
//  GameScoreStore.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class GameScoreStore {

    private let defaults = UserDefaults.standard
    private let statsPrefix = "gameStatistics"
    private let legacyScorePrefix = "gameBestScore"

    func statistics(for game: GameKind) -> GameStatistics {
        guard
            let data = defaults.data(forKey: statsKey(for: game)),
            let decoded = try? JSONDecoder().decode(GameStatistics.self, from: data)
        else {
            var stats = GameStatistics()
            let legacyBest = defaults.integer(forKey: legacyKey(for: game))
            if legacyBest > 0 {
                stats.bestScore = legacyBest
            }
            let legacyXP = defaults.integer(forKey: legacyXPKey(for: game))
            if legacyXP > 0 {
                stats.xpEarned = legacyXP
            }
            return stats
        }
        return decoded
    }

    func bestScore(for game: GameKind) -> Int {
        statistics(for: game).bestScore
    }

    func totalXP(for game: GameKind) -> Int {
        statistics(for: game).xpEarned
    }

    func totalXPAllGames() -> Int {
        GameKind.allCases.reduce(0) { $0 + totalXP(for: $1) }
    }

    @discardableResult
    func record(result: GameResult, streak: Int = 0) -> Bool {
        var stats = statistics(for: result.gameKind)
        stats.gamesPlayed += 1
        stats.totalCorrect += result.correctCount
        stats.totalWrong += result.wrongCount
        stats.totalTimeSeconds += result.elapsedSeconds
        stats.xpEarned += result.xpEarned
        stats.longestStreak = max(stats.longestStreak, max(streak, result.comboPeak))

        let isNewRecord = result.score > stats.bestScore
        if isNewRecord {
            stats.bestScore = result.score
        }

        persist(stats, for: result.gameKind)
        return isNewRecord
    }

    @discardableResult
    func record(score: Int, for game: GameKind) -> Bool {
        var stats = statistics(for: game)
        let isNewRecord = score > stats.bestScore
        if isNewRecord {
            stats.bestScore = score
            persist(stats, for: game)
        }
        return isNewRecord
    }

    func addXP(_ xp: Int, for game: GameKind) {
        var stats = statistics(for: game)
        stats.xpEarned += xp
        persist(stats, for: game)
    }

    private func persist(_ stats: GameStatistics, for game: GameKind) {
        guard let data = try? JSONEncoder().encode(stats) else { return }
        defaults.set(data, forKey: statsKey(for: game))
        defaults.set(stats.bestScore, forKey: legacyKey(for: game))
        defaults.set(stats.xpEarned, forKey: legacyXPKey(for: game))
    }

    private func statsKey(for game: GameKind) -> String {
        "\(statsPrefix).\(game.rawValue)"
    }

    private func legacyKey(for game: GameKind) -> String {
        "\(legacyScorePrefix).\(game.rawValue)"
    }

    private func legacyXPKey(for game: GameKind) -> String {
        "\(legacyScorePrefix).\(game.rawValue).xp"
    }
}
