//
//  WordCatalog.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import Foundation
import Observation

@Observable
final class WordCatalog {

    private(set) var entries: [IndexedWord] = []

    init() {
        loadAllWords()
    }

    func search(query: String, filters: SearchFilters = SearchFilters()) -> [IndexedWord] {
        let normalized = query
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !normalized.isEmpty else { return [] }

        return entries.filter { entry in
            guard filters.matches(entry) else { return false }
            return entry.searchableText.contains(normalized)
        }
    }

    func filteredEntries(filters: SearchFilters) -> [IndexedWord] {
        entries.filter { filters.matches($0) }
    }

    func allWords() -> [IndexedWord] {
        entries
    }

    func wordCount(for fileName: String) -> Int {
        entries.filter { $0.level.fileName == fileName }.count
    }

    func hanziSet(for fileName: String) -> Set<String> {
        Set(entries.filter { $0.level.fileName == fileName }.map { $0.word.hanzi })
    }

    func learnedCount(for fileName: String, store: LearnedWordsStore) -> Int {
        store.learnedCount(for: fileName, validHanzi: hanziSet(for: fileName))
    }

    func formattedWordCount(for fileName: String) -> String {
        "\(wordCount(for: fileName)) words"
    }

    private func loadAllWords() {
        entries = SampleStudySets.all.flatMap { studySet in
            let level = WordLevel(fileName: studySet.fileName)
            return WordLoader.load(fileName: studySet.fileName).map { word in
                IndexedWord(word: word, level: level)
            }
        }
    }
}
