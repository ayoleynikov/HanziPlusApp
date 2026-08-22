//
//  WordLoader.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import Foundation
import os

enum WordLoader {

    private static let logger = Logger(subsystem: "HanziPlus", category: "WordLoader")
    private static var cache: [String: [Word]] = [:]

    static func load(fileName: String) -> [Word] {
        if let cached = cache[fileName] {
            return cached
        }

        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            logger.error("JSON file not found: \(fileName).json")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let words = try JSONDecoder().decode([Word].self, from: data)
            cache[fileName] = words
            #if DEBUG
            logDecodedExamples(from: words, fileName: fileName)
            #endif
            return words
        } catch {
            logger.error("JSON decode failed for \(fileName).json: \(error.localizedDescription)")
            return []
        }
    }

    #if DEBUG
    private static func logDecodedExamples(from words: [Word], fileName: String) {
        guard let word = words.first, let example = word.examples.first else { return }

        print("""
        📖 [WordLoader] \(fileName) — first decoded example:
           hanzi:   \(example.hanzi)
           pinyin:  \(example.pinyin ?? "nil")
           english: \(example.english ?? "nil")
        """)
    }
    #endif
}
