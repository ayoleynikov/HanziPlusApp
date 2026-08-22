//
//  LearnedWordsStore.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import Foundation
import Observation

@Observable
final class LearnedWordsStore {

    private let defaults = UserDefaults.standard
    private let storageKey = "learnedWordIDs"

    private(set) var learnedIDs: Set<String> = []

    init() {
        load()
    }

    static func wordID(fileName: String, hanzi: String) -> String {
        "\(fileName)-\(hanzi)"
    }

    func isLearned(word: Word, in studySet: StudySet) -> Bool {
        learnedIDs.contains(Self.wordID(fileName: studySet.fileName, hanzi: word.hanzi))
    }

    func isLearned(fileName: String, hanzi: String) -> Bool {
        learnedIDs.contains(Self.wordID(fileName: fileName, hanzi: hanzi))
    }

    @discardableResult
    func markLearned(fileName: String, hanzi: String) -> Bool {
        let id = Self.wordID(fileName: fileName, hanzi: hanzi)
        guard !learnedIDs.contains(id) else { return false }
        learnedIDs.insert(id)
        persist()
        return true
    }

    @discardableResult
    func markLearned(word: Word, in studySet: StudySet) -> Bool {
        markLearned(fileName: studySet.fileName, hanzi: word.hanzi)
    }

    @discardableResult
    func toggle(word: Word, in studySet: StudySet) -> Bool {
        let id = Self.wordID(fileName: studySet.fileName, hanzi: word.hanzi)

        if learnedIDs.contains(id) {
            learnedIDs.remove(id)
            persist()
            return false
        }

        learnedIDs.insert(id)
        persist()
        return true
    }

    func learnedCount(for fileName: String, validHanzi: Set<String>? = nil) -> Int {
        let prefix = "\(fileName)-"
        let matching = learnedIDs.filter { $0.hasPrefix(prefix) }
        guard let validHanzi else { return matching.count }
        return matching.filter { id in
            let hanzi = String(id.dropFirst(prefix.count))
            return validHanzi.contains(hanzi)
        }.count
    }

    func progress(for fileName: String, total: Int) -> Double {
        guard total > 0 else { return 0 }
        return Double(learnedCount(for: fileName)) / Double(total)
    }

    func percentage(for fileName: String, total: Int) -> Int {
        Int(progress(for: fileName, total: total) * 100)
    }

    func reset(fileName: String) {
        let prefix = "\(fileName)-"
        learnedIDs = learnedIDs.filter { !$0.hasPrefix(prefix) }
        persist()
    }

    private func load() {
        guard let values = defaults.stringArray(forKey: storageKey) else { return }
        learnedIDs = Set(values)
    }

    private func persist() {
        defaults.set(Array(learnedIDs), forKey: storageKey)
    }
}
