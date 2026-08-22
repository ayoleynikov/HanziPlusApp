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

    func isSatisfied(journeyStore: JourneyStore, totalXP: Int) -> Bool {
        switch self {
        case .completeCity(let name), .unlockInCity(let name):
            guard let city = JourneyCityCatalog.all.first(where: { $0.name == name }) else { return false }
            return journeyStore.isCompleted(city)
        case .reachLevel(let level):
            return GamesPlayerLevel.level(totalXP: totalXP) >= level
        }
    }
}

enum GameAvailability {

    static func isPlayable(
        _ game: GameDefinition,
        journeyStore: JourneyStore,
        totalXP: Int
    ) -> Bool {
        guard game.kind.isAvailable else { return false }
        guard let requirement = game.lockRequirement else { return true }
        return requirement.isSatisfied(journeyStore: journeyStore, totalXP: totalXP)
    }

    static func lockedGames(
        journeyStore: JourneyStore,
        totalXP: Int
    ) -> [(game: GameDefinition, requirement: GameLockRequirement)] {
        GameDefinition.catalog.compactMap { game in
            guard let requirement = game.lockRequirement else { return nil }
            guard game.kind.isAvailable else { return nil }
            guard !requirement.isSatisfied(journeyStore: journeyStore, totalXP: totalXP) else { return nil }
            return (game, requirement)
        }
    }

    static var playableLibraryGames: [GameDefinition] {
        GameDefinition.libraryGames.filter(\.kind.isAvailable)
    }
}
