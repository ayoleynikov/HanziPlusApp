//
//  GamesDailyProgressStore.swift
//  HanziPlus
//

import Foundation
import Observation

struct GamesDailyProgress: Codable, Equatable {
    var dateKey: String = ""
    var gamesPlayed: Int = 0
    var xpEarned: Int = 0
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var bestCombo: Int = 0
    var currentStreak: Int = 0

    var accuracy: Int {
        let total = correctAnswers + wrongAnswers
        guard total > 0 else { return 0 }
        return Int(Double(correctAnswers) / Double(total) * 100)
    }
}

@Observable
final class GamesDailyProgressStore {

    private let defaults = UserDefaults.standard
    private let progressKey = "games.dailyProgress"
    private let weeklyXPKey = "games.weeklyXPLog"

    private(set) var progress = GamesDailyProgress()
    private var weeklyXPLog: [String: Int] = [:]

    init() {
        load()
        refreshIfNeeded()
        pruneWeeklyLog()
    }

    var weeklyXP: Int {
        pruneWeeklyLog()
        return weeklyXPLog.values.reduce(0, +)
    }

    func recordSession(result: GameResult, comboPeak: Int = 0, streak: Int = 0) {
        refreshIfNeeded()
        progress.gamesPlayed += 1
        progress.xpEarned += result.xpEarned
        progress.correctAnswers += result.correctCount
        progress.wrongAnswers += result.wrongCount
        progress.bestCombo = max(progress.bestCombo, comboPeak, result.comboPeak)
        progress.currentStreak = max(progress.currentStreak, streak)
        addWeeklyXP(result.xpEarned)
        persist()
    }

    func recordQuickPlay(xp: Int, correct: Int, wrong: Int, comboPeak: Int = 0) {
        refreshIfNeeded()
        progress.gamesPlayed += 1
        progress.xpEarned += xp
        progress.correctAnswers += correct
        progress.wrongAnswers += wrong
        progress.bestCombo = max(progress.bestCombo, comboPeak)
        addWeeklyXP(xp)
        persist()
    }

    private func addWeeklyXP(_ xp: Int) {
        let key = Self.dateKey(for: .now)
        weeklyXPLog[key, default: 0] += xp
        defaults.set(weeklyXPLog, forKey: weeklyXPKey)
    }

    private func pruneWeeklyLog() {
        let calendar = Calendar.current
        let cutoff = calendar.date(byAdding: .day, value: -7, to: .now) ?? .now
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        weeklyXPLog = weeklyXPLog.filter { key, _ in
            guard let date = formatter.date(from: key) else { return false }
            return date >= cutoff
        }
    }

    private func refreshIfNeeded() {
        let today = Self.dateKey(for: .now)
        if progress.dateKey != today {
            progress = GamesDailyProgress(dateKey: today)
            persist()
        }
    }

    private static func dateKey(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    private func load() {
        if
            let data = defaults.data(forKey: progressKey),
            let decoded = try? JSONDecoder().decode(GamesDailyProgress.self, from: data)
        {
            progress = decoded
        }
        weeklyXPLog = defaults.dictionary(forKey: weeklyXPKey) as? [String: Int] ?? [:]
        refreshIfNeeded()
    }

    private func persist() {
        guard let data = try? JSONEncoder().encode(progress) else { return }
        defaults.set(data, forKey: progressKey)
    }

    func resetAll() {
        progress = GamesDailyProgress(dateKey: Self.dateKey(for: .now))
        weeklyXPLog.removeAll()
        defaults.removeObject(forKey: weeklyXPKey)
        persist()
    }
}
