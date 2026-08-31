//
//  SentenceTokenizer.swift
//  HanziPlus
//

import Foundation

enum SentenceTokenizer {

    private static let punctuation = CharacterSet(charactersIn: "。，！？、.?!, ")

    static func tokenize(sentence: String, vocabulary: [String]) -> [String] {
        let cleaned = sentence.trimmingCharacters(in: punctuation)
        guard !cleaned.isEmpty else { return [] }

        let sortedVocab = vocabulary
            .filter { !$0.isEmpty }
            .sorted { $0.count > $1.count }

        var tokens: [String] = []
        var remaining = cleaned

        while !remaining.isEmpty {
            if let match = sortedVocab.first(where: { remaining.hasPrefix($0) }) {
                tokens.append(match)
                remaining.removeFirst(match.count)
            } else {
                tokens.append(String(remaining.prefix(1)))
                remaining.removeFirst(1)
            }
        }

        return tokens.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
    }

    static func normalized(_ sentence: String) -> String {
        sentence
            .trimmingCharacters(in: punctuation)
            .replacingOccurrences(of: " ", with: "")
    }
}

struct SentencePuzzle: Identifiable {
    let id = UUID()
    let sourceWord: Word
    let example: Example
    let tokens: [String]
    let correctOrder: [String]

    var hanzi: String { example.hanzi }
    var localizedHint: String { example.localizedMeaning ?? "" }
    var english: String { localizedHint }

    static func puzzles(from studySet: StudySet, limit: Int = 10) -> [SentencePuzzle] {
        let vocabulary = GameWordProvider.vocabularyHanzi(for: studySet)
        let words = WordLoader.load(fileName: studySet.fileName)

        var puzzles: [SentencePuzzle] = []

        for word in words.shuffled() {
            for example in word.examples where !example.hanzi.isEmpty {
                let tokens = SentenceTokenizer.tokenize(
                    sentence: example.hanzi,
                    vocabulary: vocabulary
                )

                guard
                    tokens.count >= 3,
                    tokens.count <= 8,
                    let meaning = example.localizedMeaning,
                    !meaning.isEmpty
                else { continue }

                puzzles.append(SentencePuzzle(
                    sourceWord: word,
                    example: example,
                    tokens: tokens,
                    correctOrder: tokens
                ))
            }
        }

        return Array(puzzles.shuffled().prefix(limit))
    }
}
