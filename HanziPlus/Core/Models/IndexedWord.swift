//
//  IndexedWord.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import Foundation

struct IndexedWord: Identifiable, Sendable {

    let word: Word
    let level: WordLevel
    let searchableText: String

    var id: String {
        "\(level.fileName)-\(word.hanzi)"
    }

    init(word: Word, level: WordLevel) {
        self.word = word
        self.level = level
        self.searchableText = [
            word.hanzi,
            word.pinyin.lowercased(),
            word.english.lowercased(),
            word.searchableTranslationBlob()
        ].joined(separator: " ")
    }
}
