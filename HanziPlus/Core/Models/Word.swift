//
//  Word.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import Foundation

struct Word: Identifiable, Codable {

    /// Stable identity — Hanzi only (never depends on UI language).
    var id: String { hanzi }
    let hanzi: String
    let pinyin: String
    /// Legacy English gloss (kept for backward compatibility).
    let english: String
    let examples: [Example]
    let section: String?
    /// Optional multilingual glosses (`en`, `ru`, `es`, `pt-BR`).
    let translations: [String: String]?

    /// Prefer `localizedTranslation(for:)` — English-only convenience for legacy call sites.
    var translation: String {
        localizedMeaning
    }

    /// Current UI content language (see `LocalizedContent.currentLanguage`).
    var localizedMeaning: String {
        localizedTranslation(for: LocalizedContent.currentLanguage)
    }

    func localizedTranslation(for language: ContentLanguageCode) -> String {
        LocalizedContent.pick(
            from: translations,
            code: language.rawValue,
            englishFallback: english
        )
    }

    func localizedTranslation(forAppLanguage language: AppLanguage) -> String {
        localizedTranslation(for: ContentLanguageCode(appLanguage: language))
    }

    func searchableTranslationBlob() -> String {
        LocalizedContent.searchableBlob(
            translations: translations,
            englishFallback: english
        )
    }

    private enum CodingKeys: String, CodingKey {
        case hanzi
        case pinyin
        case english
        case examples
        case section
        case translations
    }

    init(
        hanzi: String,
        pinyin: String,
        english: String,
        examples: [Example] = [],
        section: String? = nil,
        translations: [String: String]? = nil
    ) {
        self.hanzi = hanzi
        self.pinyin = pinyin
        self.english = english
        self.examples = examples
        self.section = section
        self.translations = translations
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hanzi = try container.decode(String.self, forKey: .hanzi)
        pinyin = try container.decode(String.self, forKey: .pinyin)
        english = try container.decode(String.self, forKey: .english)
        examples = try container.decodeIfPresent([Example].self, forKey: .examples) ?? []
        section = try container.decodeIfPresent(String.self, forKey: .section)
        translations = try container.decodeIfPresent([String: String].self, forKey: .translations)
    }
}
