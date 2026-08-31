//
//  GameKind.swift
//  HanziPlus
//

import SwiftUI

enum GameKind: String, CaseIterable, Identifiable, Codable {
    case matchPairs
    case speedChallenge
    case sentenceBuilder
    case listeningQuiz
    case hanziMemory
    case findTheHanzi
    case typingChallenge
    case dailyChallenge
    case smartReview

    var id: String { rawValue }

    var isAvailable: Bool { true }
}

enum GameDifficulty: String, Codable, CaseIterable, Hashable {
    case easy
    case medium
    case hard

    var label: String {
        switch self {
        case .easy: L10n.string( "games.difficulty.easy")
        case .medium: L10n.string( "games.difficulty.medium")
        case .hard: L10n.string( "games.difficulty.hard")
        }
    }

    var color: Color {
        switch self {
        case .easy: .green
        case .medium: .orange
        case .hard: .red
        }
    }
}
