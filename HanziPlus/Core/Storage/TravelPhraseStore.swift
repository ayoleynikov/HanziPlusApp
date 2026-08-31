//
//  TravelPhraseStore.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class TravelPhraseStore {

    private let defaults = UserDefaults.standard
    private let favoritesKey = "travelPhrases.favoriteIDs"
    private let recentKey = "travelPhrases.recentIDs"
    private let maxRecent = 20

    private(set) var favoriteIDs: [String] = []
    private(set) var recentIDs: [String] = []

    init() {
        load()
    }

    func isFavorite(_ phraseID: String) -> Bool {
        favoriteIDs.contains(phraseID)
    }

    func toggleFavorite(_ phraseID: String) {
        if let index = favoriteIDs.firstIndex(of: phraseID) {
            favoriteIDs.remove(at: index)
        } else {
            favoriteIDs.insert(phraseID, at: 0)
        }
        persistFavorites()
    }

    func markUsed(_ phraseID: String) {
        recentIDs.removeAll { $0 == phraseID }
        recentIDs.insert(phraseID, at: 0)
        if recentIDs.count > maxRecent {
            recentIDs = Array(recentIDs.prefix(maxRecent))
        }
        persistRecent()
    }

    var favoritePhrases: [TravelPhrase] {
        favoriteIDs.compactMap { TravelPhraseCatalog.phrase(id: $0) }
    }

    var recentPhrases: [TravelPhrase] {
        recentIDs.compactMap { TravelPhraseCatalog.phrase(id: $0) }
    }

    func resetAll() {
        favoriteIDs = []
        recentIDs = []
        persistFavorites()
        persistRecent()
    }

    private func load() {
        favoriteIDs = defaults.stringArray(forKey: favoritesKey) ?? []
        recentIDs = defaults.stringArray(forKey: recentKey) ?? []
    }

    private func persistFavorites() {
        defaults.set(favoriteIDs, forKey: favoritesKey)
    }

    private func persistRecent() {
        defaults.set(recentIDs, forKey: recentKey)
    }
}
