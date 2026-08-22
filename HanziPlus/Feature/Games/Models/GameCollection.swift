//
//  GameCollection.swift
//  HanziPlus
//

import SwiftUI

enum GameCollection: String, CaseIterable, Identifiable {
    case vocabulary
    case memory
    case listening
    case speed
    case writing
    case review

    var id: String { rawValue }

    var title: String {
        String(localized: String.LocalizationValue("games.collection.\(rawValue).title"))
    }

    var subtitle: String {
        String(localized: String.LocalizationValue("games.collection.\(rawValue).subtitle"))
    }

    var emoji: String {
        switch self {
        case .vocabulary: "🧩"
        case .memory: "🀄"
        case .listening: "🎤"
        case .speed: "⚡"
        case .writing: "✍️"
        case .review: "🧠"
        }
    }

    var tint: Color {
        switch self {
        case .vocabulary: .blue
        case .memory: .indigo
        case .listening: .teal
        case .speed: .orange
        case .writing: .pink
        case .review: .cyan
        }
    }

    var artworkColors: [Color] {
        switch self {
        case .vocabulary: [Color(red: 0.08, green: 0.15, blue: 0.45), .blue, .cyan]
        case .memory: [Color(red: 0.12, green: 0.08, blue: 0.42), .indigo, .purple]
        case .listening: [Color(red: 0.05, green: 0.28, blue: 0.32), .teal, .mint]
        case .speed: [Color(red: 0.18, green: 0.06, blue: 0.28), .indigo, .orange]
        case .writing: [Color(red: 0.28, green: 0.08, blue: 0.18), .pink, .orange]
        case .review: [Color(red: 0.08, green: 0.18, blue: 0.32), .cyan, .blue]
        }
    }

    var games: [GameDefinition] {
        GameDefinition.libraryGames.filter { $0.collection == self }
    }

    /// Collections shown in the hub carousel.
    static var featured: [GameCollection] {
        allCases.filter { !$0.games.isEmpty }
    }
}
