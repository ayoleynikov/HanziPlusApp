//
//  Example.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/27.
//

import Foundation

struct Example: Identifiable, Codable, Hashable {

    let hanzi: String
    let pinyin: String?
    let english: String?
    let translations: [String: String]?

    /// Stable id — does not depend on selected UI language.
    var id: String {
        "\(hanzi)|\(pinyin ?? "")|\(english ?? "")"
    }

    init(
        hanzi: String,
        pinyin: String? = nil,
        english: String? = nil,
        translations: [String: String]? = nil
    ) {
        self.hanzi = hanzi
        self.pinyin = Self.nilIfEmpty(pinyin)
        self.english = Self.nilIfEmpty(english)
        self.translations = translations
    }

    func localizedTranslation(for language: ContentLanguageCode) -> String? {
        let value = LocalizedContent.pick(
            from: translations,
            code: language.rawValue,
            englishFallback: english
        )
        return value.isEmpty ? nil : value
    }

    func localizedTranslation(forAppLanguage language: AppLanguage) -> String? {
        localizedTranslation(for: ContentLanguageCode(appLanguage: language))
    }

    init(from decoder: Decoder) throws {
        if let legacy = try? decoder.singleValueContainer().decode(String.self) {
            self.init(hanzi: legacy)
            return
        }

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let hanzi = try container.decode(String.self, forKey: .hanzi)
        let pinyin = try container.decodeIfPresent(String.self, forKey: .pinyin)
        let english = try container.decodeIfPresent(String.self, forKey: .english)
        let translations = try container.decodeIfPresent([String: String].self, forKey: .translations)
        self.init(hanzi: hanzi, pinyin: pinyin, english: english, translations: translations)
    }

    func encode(to encoder: Encoder) throws {
        if pinyin == nil, english == nil, translations == nil {
            var container = encoder.singleValueContainer()
            try container.encode(hanzi)
            return
        }

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hanzi, forKey: .hanzi)
        try container.encodeIfPresent(pinyin, forKey: .pinyin)
        try container.encodeIfPresent(english, forKey: .english)
        try container.encodeIfPresent(translations, forKey: .translations)
    }

    private enum CodingKeys: String, CodingKey {
        case hanzi
        case pinyin
        case english
        case translations
    }

    private static func nilIfEmpty(_ value: String?) -> String? {
        guard let value, !value.isEmpty else { return nil }
        return value
    }
}

extension Example {

    static let legacyPreview = Example(hanzi: "我爱你。")

    static let modernPreview = Example(
        hanzi: "我爱你。",
        pinyin: "Wǒ ài nǐ.",
        english: "I love you.",
        translations: [
            "en": "I love you.",
            "ru": "Я люблю тебя.",
            "es": "Te quiero.",
            "pt-BR": "Eu te amo."
        ]
    )
}
