//
//  GamesPlayHistoryStore.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class GamesPlayHistoryStore {

    private let defaults = UserDefaults.standard
    private let historyKey = "games.recentlyPlayed"
    private let maxEntries = 6

    private(set) var recentlyPlayed: [GameKind] = []

    init() {
        load()
    }

    func recordPlay(_ kind: GameKind) {
        recentlyPlayed.removeAll { $0 == kind }
        recentlyPlayed.insert(kind, at: 0)
        if recentlyPlayed.count > maxEntries {
            recentlyPlayed = Array(recentlyPlayed.prefix(maxEntries))
        }
        defaults.set(recentlyPlayed.map(\.rawValue), forKey: historyKey)
    }

    private func load() {
        let raw = defaults.stringArray(forKey: historyKey) ?? []
        recentlyPlayed = raw.compactMap(GameKind.init(rawValue:))
    }
}
