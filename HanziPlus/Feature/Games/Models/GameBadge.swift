//
//  GameBadge.swift
//  HanziPlus
//

import SwiftUI

enum GameBadge: String, CaseIterable {
    case featured
    case new
    case popular
    case recommended
    case recentlyPlayed
    case perfectForBeginners

    var label: String {
        switch self {
        case .featured: "Featured"
        case .new: "New"
        case .popular: "Popular"
        case .recommended: "Recommended"
        case .recentlyPlayed: "Recent"
        case .perfectForBeginners: "Beginners"
        }
    }

    var tint: Color {
        switch self {
        case .featured: .purple
        case .new: .green
        case .popular: .orange
        case .recommended: .cyan
        case .recentlyPlayed: .blue
        case .perfectForBeginners: .mint
        }
    }
}

struct GameBadgePill: View {
    let badge: GameBadge

    var body: some View {
        Text(badge.label)
            .font(.caption2.weight(.bold))
            .foregroundStyle(badge.tint)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Capsule(style: .continuous).fill(badge.tint.opacity(0.14)))
    }
}

enum GameHubBadgeResolver {

    static let popularKinds: Set<GameKind> = [.hanziMemory, .speedChallenge, .listeningQuiz]
    static let beginnerKinds: Set<GameKind> = [.hanziMemory, .matchPairs, .listeningQuiz]

    static func badges(
        for game: GameDefinition,
        featuredKinds: Set<GameKind>,
        recommendedKind: GameKind,
        recentlyPlayed: [GameKind],
        gamesPlayed: Int
    ) -> [GameBadge] {
        var result: [GameBadge] = []

        if featuredKinds.contains(game.kind) { result.append(.featured) }
        if gamesPlayed == 0 { result.append(.new) }
        if popularKinds.contains(game.kind) { result.append(.popular) }
        if game.kind == recommendedKind { result.append(.recommended) }
        if recentlyPlayed.first == game.kind { result.append(.recentlyPlayed) }
        if beginnerKinds.contains(game.kind) && game.difficulty == .easy { result.append(.perfectForBeginners) }

        return Array(result.prefix(2))
    }
}

enum GamesPlayerLevel {
    static func level(totalXP: Int) -> Int {
        max(1, totalXP / 300 + 1)
    }

    static func progress(totalXP: Int) -> Double {
        let xpInLevel = totalXP % 300
        return Double(xpInLevel) / 300.0
    }

    static func xpInCurrentLevel(totalXP: Int) -> Int {
        totalXP % 300
    }
}
