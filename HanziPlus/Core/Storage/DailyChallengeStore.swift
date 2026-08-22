//
//  DailyChallengeStore.swift
//  HanziPlus
//

import Foundation
import Observation

struct DailyChallengeTask: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let kind: GameKind
    let targetCount: Int

    var localizedTitle: String {
        String(localized: String.LocalizationValue("games.daily.task.\(id)"))
    }
}

struct DailyChallengeState: Codable, Equatable {
    var dateKey: String
    var tasks: [DailyChallengeTask]
    var completedTaskIDs: Set<String>
    var isFullyCompleted: Bool
    var xpAwarded: Int

    var completionProgress: Double {
        guard !tasks.isEmpty else { return 0 }
        return Double(completedTaskIDs.count) / Double(tasks.count)
    }
}

@Observable
final class DailyChallengeStore {

    private let defaults = UserDefaults.standard
    private let stateKey = "dailyChallenge.state"
    private let historyKey = "dailyChallenge.history"

    private(set) var state: DailyChallengeState
    private(set) var completionHistory: [String] = []

    init() {
        if
            let data = defaults.data(forKey: stateKey),
            let decoded = try? JSONDecoder().decode(DailyChallengeState.self, from: data),
            decoded.dateKey == Self.todayKey()
        {
            state = decoded
        } else {
            state = Self.generate(for: Self.todayKey())
        }

        completionHistory = defaults.stringArray(forKey: historyKey) ?? []
    }

    static func todayKey() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    func refreshIfNeeded() {
        let today = Self.todayKey()
        guard state.dateKey != today else { return }
        state = Self.generate(for: today)
        persist()
    }

    func completeTask(_ taskID: String, xp: Int) {
        state.completedTaskIDs.insert(taskID)

        if state.completedTaskIDs.count == state.tasks.count, !state.isFullyCompleted {
            state.isFullyCompleted = true
            state.xpAwarded = xp
            if !completionHistory.contains(state.dateKey) {
                completionHistory.append(state.dateKey)
                defaults.set(completionHistory, forKey: historyKey)
            }
        }

        persist()
    }

    var streakDays: Int {
        guard !completionHistory.isEmpty else { return 0 }

        let sorted = completionHistory.sorted(by: >)
        var streak = 0
        var checkDate = Date()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        for _ in 0..<sorted.count {
            let key = formatter.string(from: checkDate)
            if sorted.contains(key) {
                streak += 1
                checkDate = Calendar.current.date(byAdding: .day, value: -1, to: checkDate) ?? checkDate
            } else if streak > 0 {
                break
            } else {
                checkDate = Calendar.current.date(byAdding: .day, value: -1, to: checkDate) ?? checkDate
            }
        }

        return streak
    }

    private func persist() {
        guard let data = try? JSONEncoder().encode(state) else { return }
        defaults.set(data, forKey: stateKey)
    }

    private static func generate(for dateKey: String) -> DailyChallengeState {
        DailyChallengeState(
            dateKey: dateKey,
            tasks: [
                DailyChallengeTask(id: "match", title: "5 Match Pairs", kind: .matchPairs, targetCount: 5),
                DailyChallengeTask(id: "speed", title: "10 Speed Questions", kind: .speedChallenge, targetCount: 10),
                DailyChallengeTask(id: "listening", title: "5 Listening Questions", kind: .listeningQuiz, targetCount: 5),
                DailyChallengeTask(id: "typing", title: "5 Typing Questions", kind: .typingChallenge, targetCount: 5)
            ],
            completedTaskIDs: [],
            isFullyCompleted: false,
            xpAwarded: 0
        )
    }
}
