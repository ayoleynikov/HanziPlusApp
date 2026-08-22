//
//  JourneyRequirement.swift
//  HanziPlus
//

import Foundation

enum JourneyRequirementKind: String, Equatable, Codable {
    case learnedWords
    case xp
    case gamesPlayed
    case accuracy
    case hsk1Complete
    case hsk2Complete
    case dailyChallengeStreak
    case achievement
}

struct JourneyRequirement: Identifiable, Equatable {
    let id: String
    let kind: JourneyRequirementKind
    let title: String
    let target: Int

    func evaluate(with progress: JourneyProgress, dailyStreak: Int = 0) -> RequirementEvaluation {
        switch kind {
        case .learnedWords:
            return numericEvaluation(
                current: progress.learnedWords,
                target: target,
                title: title
            )

        case .xp:
            return numericEvaluation(
                current: progress.totalXP,
                target: target,
                title: title
            )

        case .gamesPlayed:
            return numericEvaluation(
                current: progress.gamesPlayed,
                target: target,
                title: title
            )

        case .accuracy:
            return numericEvaluation(
                current: progress.accuracy,
                target: target,
                title: title
            )

        case .hsk1Complete:
            return booleanEvaluation(
                isComplete: progress.hsk1Complete,
                title: title,
                partialFraction: progress.hsk1Total > 0
                    ? Double(progress.hsk1Learned) / Double(progress.hsk1Total)
                    : 0
            )

        case .hsk2Complete:
            return booleanEvaluation(
                isComplete: progress.hsk2Complete,
                title: title,
                partialFraction: progress.hsk2Total > 0
                    ? Double(progress.hsk2Learned) / Double(progress.hsk2Total)
                    : 0
            )

        case .dailyChallengeStreak:
            return numericEvaluation(
                current: dailyStreak,
                target: target,
                title: title
            )

        case .achievement:
            return booleanEvaluation(
                isComplete: false,
                title: title,
                partialFraction: 0
            )
        }
    }

    private func numericEvaluation(current: Int, target: Int, title: String) -> RequirementEvaluation {
        let complete = current >= target
        let fraction = target > 0 ? min(1, Double(current) / Double(target)) : 1

        return RequirementEvaluation(
            id: id,
            title: title,
            isComplete: complete,
            showsProgress: true,
            currentValue: current,
            targetValue: target,
            fraction: fraction
        )
    }

    private func booleanEvaluation(
        isComplete: Bool,
        title: String,
        partialFraction: Double
    ) -> RequirementEvaluation {
        RequirementEvaluation(
            id: id,
            title: title,
            isComplete: isComplete,
            showsProgress: !isComplete && partialFraction > 0,
            currentValue: isComplete ? 1 : 0,
            targetValue: 1,
            fraction: isComplete ? 1 : partialFraction
        )
    }
}

struct RequirementEvaluation: Identifiable, Equatable {
    let id: String
    let title: String
    let isComplete: Bool
    let showsProgress: Bool
    let currentValue: Int
    let targetValue: Int
    let fraction: Double

    var statusIcon: String {
        if isComplete { return "✅" }
        if fraction > 0 { return "🟡" }
        return "❌"
    }

    var progressLabel: String? {
        guard showsProgress, targetValue > 0 else { return nil }
        return "\(currentValue) / \(targetValue)"
    }
}

struct CityRequirements: Equatable {
    let items: [JourneyRequirement]

    static let none = CityRequirements(items: [])

    func isMet(by progress: JourneyProgress, dailyStreak: Int = 0) -> Bool {
        items.allSatisfy { $0.evaluate(with: progress, dailyStreak: dailyStreak).isComplete }
    }

    func completionFraction(for progress: JourneyProgress, dailyStreak: Int = 0) -> Double {
        let evaluations = items.map { $0.evaluate(with: progress, dailyStreak: dailyStreak) }
        guard !evaluations.isEmpty else { return 1 }
        return evaluations.map(\.fraction).reduce(0, +) / Double(evaluations.count)
    }

    func evaluations(for progress: JourneyProgress, dailyStreak: Int = 0) -> [RequirementEvaluation] {
        items.map { $0.evaluate(with: progress, dailyStreak: dailyStreak) }
    }
}

enum JourneyRequirementFactory {

    static func learnedWords(_ count: Int) -> JourneyRequirement {
        JourneyRequirement(
            id: "learned-\(count)",
            kind: .learnedWords,
            title: String(localized: "journey.req.learn_words \(count)"),
            target: count
        )
    }

    static func xp(_ amount: Int) -> JourneyRequirement {
        JourneyRequirement(
            id: "xp-\(amount)",
            kind: .xp,
            title: String(localized: "journey.req.earn_xp"),
            target: amount
        )
    }

    static func gamesPlayed(_ count: Int) -> JourneyRequirement {
        JourneyRequirement(
            id: "games-\(count)",
            kind: .gamesPlayed,
            title: String(localized: "journey.req.play_games"),
            target: count
        )
    }

    static func accuracy(_ percent: Int) -> JourneyRequirement {
        JourneyRequirement(
            id: "accuracy-\(percent)",
            kind: .accuracy,
            title: String(localized: "journey.req.accuracy \(percent)"),
            target: percent
        )
    }

    static var hsk1Complete: JourneyRequirement {
        JourneyRequirement(
            id: "hsk1-complete",
            kind: .hsk1Complete,
            title: String(localized: "journey.req.hsk1"),
            target: 1
        )
    }

    static var hsk2Complete: JourneyRequirement {
        JourneyRequirement(
            id: "hsk2-complete",
            kind: .hsk2Complete,
            title: String(localized: "journey.req.hsk2"),
            target: 1
        )
    }

    static func dailyStreak(_ days: Int) -> JourneyRequirement {
        JourneyRequirement(
            id: "streak-\(days)",
            kind: .dailyChallengeStreak,
            title: "\(days)-day daily challenge streak",
            target: days
        )
    }
}
