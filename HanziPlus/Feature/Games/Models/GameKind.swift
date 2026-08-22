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
        case .easy: "Easy"
        case .medium: "Medium"
        case .hard: "Hard"
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
