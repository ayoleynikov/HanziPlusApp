//
//  GameWordProvider.swift
//  HanziPlus
//

import Foundation

enum GameWordProvider {

    static func words(for studySet: StudySet, limit: Int? = nil) -> [Word] {
        let loaded = WordLoader.load(fileName: studySet.fileName).shuffled()
        guard let limit else { return loaded }
        return Array(loaded.prefix(limit))
    }

    static func vocabularyHanzi(for studySet: StudySet) -> [String] {
        WordLoader.load(fileName: studySet.fileName).map(\.hanzi)
    }
}

enum MultipleChoiceHelper {

    static func englishOptions(
        correct: String,
        pool: [Word],
        excluding wordID: String,
        count: Int = 4
    ) -> [String] {
        meaningOptions(
            correctMeaning: correct,
            pool: pool,
            excluding: wordID,
            language: LocalizedContent.currentLanguage,
            count: count
        )
    }

    static func meaningOptions(
        correct: Word,
        pool: [Word],
        language: ContentLanguageCode = LocalizedContent.currentLanguage,
        count: Int = 4
    ) -> [String] {
        meaningOptions(
            correctMeaning: correct.localizedTranslation(for: language),
            pool: pool,
            excluding: correct.id,
            language: language,
            count: count
        )
    }

    static func meaningOptions(
        correctMeaning: String,
        pool: [Word],
        excluding wordID: String,
        language: ContentLanguageCode,
        count: Int
    ) -> [String] {
        var unique: [String] = []
        var seen = Set<String>()
        for word in pool.shuffled() where word.id != wordID {
            let value = word.localizedTranslation(for: language)
            guard !value.isEmpty, value != correctMeaning else { continue }
            if seen.insert(value).inserted {
                unique.append(value)
            }
            if unique.count >= max(0, count - 1) { break }
        }
        unique.append(correctMeaning)
        return unique.shuffled()
    }

    static func hanziOptions(
        correct: String,
        pool: [Word],
        excluding wordID: String,
        count: Int = 4
    ) -> [String] {
        valueOptions(values: \.hanzi, correct: correct, pool: pool, excluding: wordID, count: count)
    }

    static func options(
        correct: String,
        pool: [Word],
        excluding wordID: String,
        count: Int = 4
    ) -> [String] {
        englishOptions(correct: correct, pool: pool, excluding: wordID, count: count)
    }

    private static func valueOptions(
        values: KeyPath<Word, String>,
        correct: String,
        pool: [Word],
        excluding wordID: String,
        count: Int
    ) -> [String] {
        var answers = pool
            .filter { $0.id != wordID }
            .map { $0[keyPath: values] }
            .filter { $0 != correct }
            .uniquedPreservingOrder()
            .shuffled()

        answers = Array(answers.prefix(max(1, count - 1)))
        answers.append(correct)
        return answers.shuffled()
    }
}

private extension Array where Element == String {
    func uniquedPreservingOrder() -> [String] {
        var seen = Set<String>()
        var result: [String] = []
        for value in self where seen.insert(value).inserted {
            result.append(value)
        }
        return result
    }

    func ensuringContains(_ value: String, count: Int) -> [String] {
        var result = uniquedPreservingOrder()
        if !result.contains(value) {
            result.append(value)
        }
        if result.count > count {
            result = Array(result.prefix(count))
            if !result.contains(value) {
                result[result.count - 1] = value
            }
        }
        return result.shuffled()
    }
}
