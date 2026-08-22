//
//  SearchFilters.swift
//  HanziPlus
//

import Foundation

struct SearchFilters: Sendable {

    var wordFilter: SearchWordFilter = .all
    var levels: Set<WordLevel> = Set(WordLevel.allCases)
    var favoriteHanzi: Set<String> = []
    var learnedWordKeys: Set<String> = []

    func matches(_ entry: IndexedWord) -> Bool {
        guard levels.contains(entry.level) else { return false }

        switch wordFilter {
        case .all:
            return true
        case .favorites:
            return favoriteHanzi.contains(entry.word.hanzi)
        case .learned:
            let key = LearnedWordsStore.wordID(fileName: entry.level.fileName, hanzi: entry.word.hanzi)
            return learnedWordKeys.contains(key)
        }
    }
}
