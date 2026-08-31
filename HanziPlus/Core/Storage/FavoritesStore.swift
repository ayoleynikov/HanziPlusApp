//
//  FavoritesStore.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import Foundation
import Combine

final class FavoritesStore: ObservableObject {
    private let defaults = UserDefaults.standard
    private let favoritesKey = "favoriteWords"

    @Published private(set) var favorites: Set<String> = []
    
    init() {
        load()
    }

    func isFavorite(_ word: Word) -> Bool {
        return favorites.contains(word.hanzi)
    }

    func toggle(_ word: Word) {
        if favorites.contains(word.hanzi) {
            favorites.remove(word.hanzi)
        } else {
            favorites.insert(word.hanzi)
        }
        save()
    }

    func resetAll() {
        favorites.removeAll()
        save()
    }

    private func save() {
        defaults.set(Array(favorites), forKey: favoritesKey)
    }

    private func load() {
        guard let values = defaults.stringArray(forKey: favoritesKey) else {
            return
        }

        favorites = Set(values)
    }
}
