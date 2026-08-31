//
//  GameLockRequirement.swift
//  HanziPlus
//

import Foundation

enum GameLockRequirement: Equatable, Codable {
    case completeCity(cityName: String)
    case unlockInCity(cityName: String)
    case reachLevel(Int)

    var label: String {
        switch self {
        case .completeCity(let name):
            "Unlock by completing \(name)."
        case .unlockInCity(let name):
            "Unlock in \(name)."
        case .reachLevel(let level):
            "Reach Level \(level)."
        }
    }
}

enum GameAvailability {

    static func isPlayable(_ game: GameDefinition) -> Bool {
        game.kind.isAvailable
    }

    static func lockedGames() -> [(game: GameDefinition, requirement: GameLockRequirement)] {
        []
    }

    static var playableLibraryGames: [GameDefinition] {
        GameDefinition.libraryGames.filter(\.kind.isAvailable)
    }
}
