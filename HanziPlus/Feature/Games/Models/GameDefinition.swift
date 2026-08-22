//
//  GameDefinition.swift
//  HanziPlus
//

import SwiftUI

struct GameDefinition: Identifiable {
    let kind: GameKind
    let title: String
    let description: String
    let shortDescription: String
    let tagline: String
    let emoji: String
    let icon: String
    let color: Color
    let difficulty: GameDifficulty
    let collection: GameCollection
    let benefits: [String]
    let artworkColors: [Color]
    let xpReward: Int
    let estimatedMinutes: Int
    let lockRequirement: GameLockRequirement?

    var id: GameKind { kind }
    var isAvailable: Bool { kind.isAvailable }

    var localizedTitle: String {
        String(localized: String.LocalizationValue("games.def.\(kind.rawValue).title"))
    }

    var xpRewardLabel: String { String(localized: "games.xp_up_to \(xpReward)") }
    var estimatedTimeLabel: String { String(localized: "games.est_minutes \(estimatedMinutes)") }

    static let catalog: [GameDefinition] = [
        GameDefinition(
            kind: .matchPairs,
            title: "Match Pairs",
            description: "Match Chinese words with their English meanings in a fast-paced pairing game.",
            shortDescription: "Connect words with meanings",
            tagline: "Connect words with meanings",
            emoji: "🀄",
            icon: "rectangle.on.rectangle.angled",
            color: .blue,
            difficulty: .easy,
            collection: .vocabulary,
            benefits: ["Build vocabulary recognition", "Strengthen word-meaning links", "Great for beginners"],
            artworkColors: [Color(red: 0.1, green: 0.2, blue: 0.5), .blue, .cyan],
            xpReward: 120,
            estimatedMinutes: 5,
            lockRequirement: nil
        ),
        GameDefinition(
            kind: .speedChallenge,
            title: "Speed Challenge",
            description: "Answer as many questions as you can before time runs out.",
            shortDescription: "Think fast, learn faster",
            tagline: "Think fast, learn faster",
            emoji: "⚡",
            icon: "bolt.fill",
            color: .orange,
            difficulty: .medium,
            collection: .speed,
            benefits: ["Improve recall speed", "Sharpen under pressure", "Boost daily XP"],
            artworkColors: [Color(red: 0.15, green: 0.05, blue: 0.3), .indigo, .orange],
            xpReward: 200,
            estimatedMinutes: 3,
            lockRequirement: nil
        ),
        GameDefinition(
            kind: .sentenceBuilder,
            title: "Sentence Builder",
            description: "Drag words into the correct sentence order and learn natural Chinese grammar.",
            shortDescription: "Master sentence structure",
            tagline: "Master sentence structure",
            emoji: "🧩",
            icon: "text.word.spacing",
            color: .purple,
            difficulty: .hard,
            collection: .vocabulary,
            benefits: ["Learn grammar patterns", "Practice word order", "Build fluency"],
            artworkColors: [.purple, .indigo, .pink],
            xpReward: 240,
            estimatedMinutes: 8,
            lockRequirement: nil
        ),
        GameDefinition(
            kind: .listeningQuiz,
            title: "Listening Quiz",
            description: "Hear a word spoken aloud and pick the correct Hanzi.",
            shortDescription: "Train your ear",
            tagline: "Train your ear",
            emoji: "🎧",
            icon: "ear.fill",
            color: .teal,
            difficulty: .medium,
            collection: .listening,
            benefits: ["Improve listening skills", "Connect sound to script", "Prepare for real conversations"],
            artworkColors: [Color(red: 0.05, green: 0.25, blue: 0.3), .teal, .green.opacity(0.6)],
            xpReward: 180,
            estimatedMinutes: 6,
            lockRequirement: nil
        ),
        GameDefinition(
            kind: .hanziMemory,
            title: "Hanzi Memory",
            description: "Flip cards and find matching pairs to strengthen character memory.",
            shortDescription: "Memory meets mastery",
            tagline: "Memory meets mastery",
            emoji: "🧠",
            icon: "square.grid.2x2.fill",
            color: .indigo,
            difficulty: .easy,
            collection: .memory,
            benefits: ["Memorize characters visually", "Reinforce pinyin and meaning", "Low-pressure practice"],
            artworkColors: [Color(red: 0.15, green: 0.1, blue: 0.4), .indigo, .purple],
            xpReward: 150,
            estimatedMinutes: 7,
            lockRequirement: nil
        ),
        GameDefinition(
            kind: .findTheHanzi,
            title: "Find the Hanzi",
            description: "Spot the correct character hidden in a grid of look-alikes.",
            shortDescription: "Spot the difference",
            tagline: "Spot the difference",
            emoji: "🔎",
            icon: "magnifyingglass",
            color: .mint,
            difficulty: .medium,
            collection: .vocabulary,
            benefits: ["Train visual discrimination", "Notice subtle stroke differences", "Build reading accuracy"],
            artworkColors: [Color(red: 0.2, green: 0.15, blue: 0.1), .brown.opacity(0.7), .orange.opacity(0.5)],
            xpReward: 160,
            estimatedMinutes: 5,
            lockRequirement: nil
        ),
        GameDefinition(
            kind: .typingChallenge,
            title: "Typing Challenge",
            description: "Type the Hanzi for each English word and lock in active recall.",
            shortDescription: "Active recall training",
            tagline: "Active recall training",
            emoji: "✍️",
            icon: "keyboard.fill",
            color: .pink,
            difficulty: .hard,
            collection: .writing,
            benefits: ["Strengthen production skills", "Deepen character memory", "Challenge advanced learners"],
            artworkColors: [Color(red: 0.25, green: 0.1, blue: 0.15), .pink, .orange],
            xpReward: 220,
            estimatedMinutes: 8,
            lockRequirement: nil
        ),
        GameDefinition(
            kind: .dailyChallenge,
            title: "Daily Challenge",
            description: "A fresh mixed challenge every day with bonus rewards.",
            shortDescription: "New goals every day",
            tagline: "New goals every day",
            emoji: "📅",
            icon: "calendar",
            color: .yellow,
            difficulty: .medium,
            collection: .speed,
            benefits: ["Stay consistent", "Earn bonus XP", "Build a daily habit"],
            artworkColors: [.yellow, .orange, .red],
            xpReward: 300,
            estimatedMinutes: 10,
            lockRequirement: nil
        ),
        GameDefinition(
            kind: .smartReview,
            title: "Smart Review",
            description: "Focus on words you struggle with most, powered by your mistake history.",
            shortDescription: "Learn what you missed",
            tagline: "Learn what you missed",
            emoji: "🎯",
            icon: "brain.head.profile",
            color: .cyan,
            difficulty: .medium,
            collection: .review,
            benefits: ["Target weak words", "Adaptive practice", "Close knowledge gaps"],
            artworkColors: [.cyan, .blue, .teal],
            xpReward: 190,
            estimatedMinutes: 6,
            lockRequirement: nil
        )
    ]

    static var libraryGames: [GameDefinition] {
        catalog.filter { game in
            switch game.kind {
            case .hanziMemory, .speedChallenge, .listeningQuiz, .matchPairs,
                 .typingChallenge, .findTheHanzi, .sentenceBuilder, .smartReview:
                true
            default:
                false
            }
        }
    }

    static var featuredPool: [GameDefinition] { libraryGames }

    static func definition(for kind: GameKind) -> GameDefinition {
        if let match = catalog.first(where: { $0.kind == kind }) {
            return match
        }
        // Fallback for persisted sessions referencing retired game kinds.
        return catalog[0]
    }

    static func recommended(for date: Date = .now) -> GameDefinition {
        let day = Calendar.current.ordinality(of: .day, in: .year, for: date) ?? 1
        let games = libraryGames
        guard !games.isEmpty else { return catalog[0] }
        return games[day % games.count]
    }
}
