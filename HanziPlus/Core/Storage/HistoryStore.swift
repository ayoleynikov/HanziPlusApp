//
//  HistoryStore.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import Foundation
import Observation

@Observable
final class HistoryStore {

    private let defaults = UserDefaults.standard
    private let maxSearches = 10
    private let maxWords = 15

    private enum Keys {
        static let searches = "history.recentSearches"
        static let words = "history.recentWordIDs"
    }

    private(set) var recentSearches: [String] = []
    private(set) var recentWordIDs: [String] = []

    init() {
        load()
    }

    func addSearch(_ query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        recentSearches.removeAll { $0.localizedCaseInsensitiveCompare(trimmed) == .orderedSame }
        recentSearches.insert(trimmed, at: 0)

        if recentSearches.count > maxSearches {
            recentSearches = Array(recentSearches.prefix(maxSearches))
        }

        persistSearches()
    }

    func addRecentWord(id: String) {
        recentWordIDs.removeAll { $0 == id }
        recentWordIDs.insert(id, at: 0)

        if recentWordIDs.count > maxWords {
            recentWordIDs = Array(recentWordIDs.prefix(maxWords))
        }

        persistWords()
    }

    func removeSearch(_ query: String) {
        recentSearches.removeAll { $0 == query }
        persistSearches()
    }

    func clearSearches() {
        recentSearches = []
        persistSearches()
    }

    func clearRecentWords() {
        recentWordIDs = []
        persistWords()
    }

    func recentWords(from catalog: WordCatalog) -> [IndexedWord] {
        recentWordIDs.compactMap { id in
            catalog.entries.first { $0.id == id }
        }
    }

    private func load() {
        recentSearches = defaults.stringArray(forKey: Keys.searches) ?? []
        recentWordIDs = defaults.stringArray(forKey: Keys.words) ?? []
    }

    private func persistSearches() {
        defaults.set(recentSearches, forKey: Keys.searches)
    }

    private func persistWords() {
        defaults.set(recentWordIDs, forKey: Keys.words)
    }
}
