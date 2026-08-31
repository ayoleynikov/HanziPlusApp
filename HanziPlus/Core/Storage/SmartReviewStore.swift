//
//  SmartReviewStore.swift
//  HanziPlus
//

import Foundation
import Observation

struct WordMasteryRecord: Codable, Equatable {
    var mistakeCount = 0
    var correctStreak = 0
    var lastAttemptAt: Date?
    var dueAt: Date = .now
}

@Observable
final class SmartReviewStore {

    private let defaults = UserDefaults.standard
    private let wrongWordsKey = "smartReview.wrongWords"
    private let masteryKey = "smartReview.mastery.v1"

    private(set) var mastery: [String: WordMasteryRecord] = [:]

    var wrongWordIDs: Set<String> {
        Set(mastery.compactMap { key, value in
            value.mistakeCount > 0 && value.correctStreak < 2 ? key : nil
        })
    }

    init() {
        load()
    }

    static func wordKey(fileName: String, hanzi: String) -> String {
        "\(fileName)-\(hanzi)"
    }

    func recordWrong(word: Word, studySet: StudySet) {
        recordAttempt(fileName: studySet.fileName, hanzi: word.hanzi, correct: false)
    }

    func recordCorrect(word: Word, studySet: StudySet) {
        recordAttempt(fileName: studySet.fileName, hanzi: word.hanzi, correct: true)
    }

    func recordAttempt(fileName: String, hanzi: String, correct: Bool, now: Date = .now) {
        let key = Self.wordKey(fileName: fileName, hanzi: hanzi)
        var record = mastery[key] ?? WordMasteryRecord()
        record.lastAttemptAt = now
        if correct {
            record.correctStreak += 1
            let reviewDays = record.correctStreak >= 3 ? 7 : (record.correctStreak == 2 ? 3 : 1)
            record.dueAt = Calendar.current.date(byAdding: .day, value: reviewDays, to: now) ?? now
        } else {
            record.mistakeCount += 1
            record.correctStreak = 0
            record.dueAt = now
        }
        mastery[key] = record
        persist()
    }

    func isWeak(fileName: String, hanzi: String, now: Date = .now) -> Bool {
        guard let record = mastery[Self.wordKey(fileName: fileName, hanzi: hanzi)] else { return false }
        return record.mistakeCount > 0 && (record.correctStreak < 2 || record.dueAt <= now)
    }

    func reset(fileName: String) {
        let prefix = "\(fileName)-"
        mastery = mastery.filter { !$0.key.hasPrefix(prefix) }
        persist()
    }

    func resetAll() {
        mastery.removeAll()
        persist()
    }

    func reviewWords(for studySet: StudySet, learnedStore: LearnedWordsStore) -> [Word] {
        let allWords = WordLoader.load(fileName: studySet.fileName)
        let weakWords = allWords.filter {
            isWeak(fileName: studySet.fileName, hanzi: $0.hanzi)
        }
        let weakHanzi = Set(weakWords.map(\.hanzi))
        let newWords = allWords.filter {
            !learnedStore.isLearned(word: $0, in: studySet)
                && !weakHanzi.contains($0.hanzi)
        }
        let dueWords = weakWords + newWords

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
        if let data = defaults.data(forKey: masteryKey),
           let decoded = try? JSONDecoder().decode([String: WordMasteryRecord].self, from: data) {
            mastery = decoded
            return
        }

        if let values = defaults.stringArray(forKey: wrongWordsKey) {
            mastery = Dictionary(uniqueKeysWithValues: values.map {
                ($0, WordMasteryRecord(mistakeCount: 1, correctStreak: 0, lastAttemptAt: nil, dueAt: .now))
            })
            persist()
            defaults.removeObject(forKey: wrongWordsKey)
        }
    }

    private func persist() {
        guard let data = try? JSONEncoder().encode(mastery) else { return }
        defaults.set(data, forKey: masteryKey)
    }
}
