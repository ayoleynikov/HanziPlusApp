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
        count: Int = 4,
        seed: UInt64? = nil
    ) -> [String] {
        meaningOptions(
            correctMeaning: correct,
            pool: pool,
            excluding: wordID,
            language: LocalizedContent.currentLanguage,
            count: count,
            seed: seed
        )
    }

    static func meaningOptions(
        correct: Word,
        pool: [Word],
        language: ContentLanguageCode = LocalizedContent.currentLanguage,
        count: Int = 4,
        seed: UInt64? = nil
    ) -> [String] {
        meaningOptions(
            correctMeaning: correct.localizedTranslation(for: language),
            pool: pool,
            excluding: correct.id,
            language: language,
            count: count,
            seed: seed
        )
    }

    static func meaningOptions(
        correctMeaning: String,
        pool: [Word],
        excluding wordID: String,
        language: ContentLanguageCode,
        count: Int,
        seed: UInt64? = nil
    ) -> [String] {
        let candidates = pool
            .filter { $0.id != wordID }
            .map { $0.localizedTranslation(for: language) }
            .filter { !$0.isEmpty && $0 != correctMeaning }

        return buildOptions(correct: correctMeaning, candidates: candidates, count: count, seed: seed)
    }

    static func hanziOptions(
        correct: String,
        pool: [Word],
        excluding wordID: String,
        count: Int = 4,
        seed: UInt64? = nil
    ) -> [String] {
        valueOptions(
            values: \.hanzi,
            correct: correct,
            pool: pool,
            excluding: wordID,
            count: count,
            seed: seed
        )
    }

    static func options(
        correct: String,
        pool: [Word],
        excluding wordID: String,
        count: Int = 4,
        seed: UInt64? = nil
    ) -> [String] {
        englishOptions(correct: correct, pool: pool, excluding: wordID, count: count, seed: seed)
    }

    private static func valueOptions(
        values: KeyPath<Word, String>,
        correct: String,
        pool: [Word],
        excluding wordID: String,
        count: Int,
        seed: UInt64?
    ) -> [String] {
        let candidates = pool
            .filter { $0.id != wordID }
            .map { $0[keyPath: values] }
            .filter { $0 != correct }

        return buildOptions(correct: correct, candidates: candidates, count: count, seed: seed)
    }

    private static func buildOptions(
        correct: String,
        candidates: [String],
        count: Int,
        seed: UInt64?
    ) -> [String] {
        let uniqueCandidates = candidates.uniquedPreservingOrder()
        let optionSeed = seed ?? UInt64.random(in: 1...UInt64.max)

        var distractors: [String] = []
        var seen = Set<String>()
        for value in DailyLessonPlanner.seededShuffle(uniqueCandidates, seed: optionSeed) {
            if seen.insert(value).inserted {
                distractors.append(value)
            }
            if distractors.count >= max(0, count - 1) { break }
        }

        var options = distractors
        options.append(correct)

        var final: [String] = []
        var finalSeen = Set<String>()
        for value in DailyLessonPlanner.seededShuffle(options, seed: optionSeed &+ 99) {
            if finalSeen.insert(value).inserted {
                final.append(value)
            }
        }
        if !final.contains(correct) {
            final.append(correct)
        }
        return Array(final.prefix(count))
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
}
