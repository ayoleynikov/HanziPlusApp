//
//  SearchViewModel.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class SearchViewModel {

    var query = "" {
        didSet { performSearch() }
    }

    private(set) var results: [IndexedWord] = []

    var filters = SearchFilters() {
        didSet { performSearch() }
    }

    private let catalog: WordCatalog

    init(catalog: WordCatalog) {
        self.catalog = catalog
    }

    func updateFavoriteHanzi(_ favorites: Set<String>) {
        filters.favoriteHanzi = favorites
        performSearch()
    }

    func updateLearnedKeys(_ keys: Set<String>) {
        filters.learnedWordKeys = keys
        performSearch()
    }

    func setWordFilter(_ filter: SearchWordFilter) {
        filters.wordFilter = filter
    }

    func performSearch() {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.isEmpty {
            if filters.wordFilter == .all {
                results = []
            } else {
                results = catalog.filteredEntries(filters: filters)
            }
            return
        }

        results = catalog.search(query: query, filters: filters)
    }
}
