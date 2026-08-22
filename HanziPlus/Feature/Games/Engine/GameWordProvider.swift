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
        valueOptions(values: \.english, correct: correct, pool: pool, excluding: wordID, count: count)
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
            .shuffled()

        answers = Array(answers.prefix(max(1, count - 1)))
        answers.append(correct)
        return answers.shuffled()
    }
}
