//
//  SmartReviewStore.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class SmartReviewStore {

    private let defaults = UserDefaults.standard
    private let wrongWordsKey = "smartReview.wrongWords"

    private(set) var wrongWordIDs: Set<String> = []

    init() {
        load()
    }

    static func wordKey(fileName: String, hanzi: String) -> String {
        "\(fileName)-\(hanzi)"
    }

    func recordWrong(word: Word, studySet: StudySet) {
        wrongWordIDs.insert(Self.wordKey(fileName: studySet.fileName, hanzi: word.hanzi))
        persist()
    }

    func recordCorrect(word: Word, studySet: StudySet) {
        let key = Self.wordKey(fileName: studySet.fileName, hanzi: word.hanzi)
        guard wrongWordIDs.contains(key) else { return }
        wrongWordIDs.remove(key)
        persist()
    }

    func reset(fileName: String) {
        let prefix = "\(fileName)-"
        wrongWordIDs = wrongWordIDs.filter { !$0.hasPrefix(prefix) }
        persist()
    }

    func resetAll() {
        wrongWordIDs.removeAll()
        persist()
    }

    func reviewWords(for studySet: StudySet, learnedStore: LearnedWordsStore) -> [Word] {
        let allWords = WordLoader.load(fileName: studySet.fileName)
        let prefix = "\(studySet.fileName)-"

        let dueWords = allWords.filter { word in
            let key = Self.wordKey(fileName: studySet.fileName, hanzi: word.hanzi)
            let isLearned = learnedStore.isLearned(word: word, in: studySet)
            let wasWrong = wrongWordIDs.contains(key)
            return wasWrong || !isLearned
        }

        if dueWords.isEmpty {
            return Array(allWords.shuffled().prefix(12))
        }

        return dueWords.shuffled()
    }

    func dueCount(for studySet: StudySet, learnedStore: LearnedWordsStore) -> Int {
        reviewWords(for: studySet, learnedStore: learnedStore).count
    }

    func estimatedMinutes(for count: Int) -> Int {
        max(1, Int(ceil(Double(count) * 0.35)))
    }

    private func load() {
        if let values = defaults.stringArray(forKey: wrongWordsKey) {
            wrongWordIDs = Set(values)
        }
    }

    private func persist() {
        defaults.set(Array(wrongWordIDs), forKey: wrongWordsKey)
    }
}
