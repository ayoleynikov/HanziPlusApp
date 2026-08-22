//
//  TravelPhrase.swift
//  HanziPlus
//

import Foundation

struct TravelPhraseReply: Codable, Hashable, Identifiable {
    var id: String { "\(chinese)-\(english)" }
    let chinese: String
    let pinyin: String
    let english: String
    let translations: [String: String]?

    init(
        chinese: String,
        pinyin: String,
        english: String,
        translations: [String: String]? = nil
    ) {
        self.chinese = chinese
        self.pinyin = pinyin
        self.english = english
        self.translations = translations
    }

    func localizedTranslation(for language: ContentLanguageCode = LocalizedContent.currentLanguage) -> String {
        LocalizedContent.pick(
            from: translations,
            code: language.rawValue,
            englishFallback: english
        )
    }
}

struct TravelPhrase: Codable, Hashable, Identifiable {
    let id: String
    let categoryID: String
    let simplifiedChinese: String
    let pinyin: String
    let english: String
    let usageNote: String?
    let tags: [String]
    let isEmergency: Bool
    let possibleReplies: [TravelPhraseReply]?
    let translations: [String: String]?
    let usageNoteTranslations: [String: String]?
    let tagTranslations: [String: [String]]?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID
        case simplifiedChinese
        case pinyin
        case english
        case usageNote
        case tags
        case isEmergency
        case possibleReplies
        case translations
        case usageNoteTranslations
        case tagTranslations
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        categoryID = try container.decode(String.self, forKey: .categoryID)
        simplifiedChinese = try container.decode(String.self, forKey: .simplifiedChinese)
        pinyin = try container.decode(String.self, forKey: .pinyin)
        english = try container.decode(String.self, forKey: .english)
        usageNote = try container.decodeIfPresent(String.self, forKey: .usageNote)
        tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
        isEmergency = try container.decodeIfPresent(Bool.self, forKey: .isEmergency) ?? false
        possibleReplies = try container.decodeIfPresent([TravelPhraseReply].self, forKey: .possibleReplies)
        translations = try container.decodeIfPresent([String: String].self, forKey: .translations)
        usageNoteTranslations = try container.decodeIfPresent([String: String].self, forKey: .usageNoteTranslations)
        tagTranslations = try container.decodeIfPresent([String: [String]].self, forKey: .tagTranslations)
    }

    func localizedTranslation(for language: ContentLanguageCode = LocalizedContent.currentLanguage) -> String {
        LocalizedContent.pick(
            from: translations,
            code: language.rawValue,
            englishFallback: english
        )
    }

    func localizedUsageNote(for language: ContentLanguageCode = LocalizedContent.currentLanguage) -> String? {
        let value = LocalizedContent.pick(
            from: usageNoteTranslations,
            code: language.rawValue,
            englishFallback: usageNote
        )
        return value.isEmpty ? nil : value
    }

    func localizedTags(for language: ContentLanguageCode = LocalizedContent.currentLanguage) -> [String] {
        if let localized = tagTranslations?[language.rawValue], !localized.isEmpty {
            return localized
        }
        if let en = tagTranslations?["en"], !en.isEmpty {
            return en
        }
        return tags
    }

    var searchableText: String {
        let translationBlob = LocalizedContent.searchableBlob(
            translations: translations,
            englishFallback: english
        )
        let noteBlob = LocalizedContent.searchableBlob(
            translations: usageNoteTranslations,
            englishFallback: usageNote
        )
        let tagBlob = (tagTranslations?.values.flatMap { $0 } ?? tags)
            .joined(separator: " ")
            .lowercased()

        return [
            simplifiedChinese,
            pinyin.lowercased(),
            english.lowercased(),
            translationBlob,
            noteBlob,
            tagBlob,
            categoryID
        ].joined(separator: " ")
    }
}

struct TravelPhraseCategory: Identifiable, Hashable {
    let id: String
    let titleKey: String
    let subtitleKey: String
    let icon: String
    /// Semantic accent key used by views (`orange`, `blue`, `red`, …).
    let accentName: String

    var title: String {
        String(localized: String.LocalizationValue(titleKey))
    }

    var subtitle: String {
        String(localized: String.LocalizationValue(subtitleKey))
    }
}

enum TravelPhraseCategories {
    static let all: [TravelPhraseCategory] = [
        TravelPhraseCategory(
            id: "essentials",
            titleKey: "travel.cat.essentials",
            subtitleKey: "travel.cat.essentials.sub",
            icon: "star.fill",
            accentName: "orange"
        ),
        TravelPhraseCategory(
            id: "airport",
            titleKey: "travel.cat.airport",
            subtitleKey: "travel.cat.airport.sub",
            icon: "airplane",
            accentName: "blue"
        ),
        TravelPhraseCategory(
            id: "transport",
            titleKey: "travel.cat.transport",
            subtitleKey: "travel.cat.transport.sub",
            icon: "tram.fill",
            accentName: "indigo"
        ),
        TravelPhraseCategory(
            id: "hotel",
            titleKey: "travel.cat.hotel",
            subtitleKey: "travel.cat.hotel.sub",
            icon: "bed.double.fill",
            accentName: "purple"
        ),
        TravelPhraseCategory(
            id: "food",
            titleKey: "travel.cat.food",
            subtitleKey: "travel.cat.food.sub",
            icon: "fork.knife",
            accentName: "pink"
        ),
        TravelPhraseCategory(
            id: "shopping",
            titleKey: "travel.cat.shopping",
            subtitleKey: "travel.cat.shopping.sub",
            icon: "bag.fill",
            accentName: "teal"
        ),
        TravelPhraseCategory(
            id: "internet",
            titleKey: "travel.cat.internet",
            subtitleKey: "travel.cat.internet.sub",
            icon: "iphone",
            accentName: "green"
        ),
        TravelPhraseCategory(
            id: "emergency",
            titleKey: "travel.cat.emergency",
            subtitleKey: "travel.cat.emergency.sub",
            icon: "cross.case.fill",
            accentName: "red"
        )
    ]

    static func category(id: String) -> TravelPhraseCategory? {
        all.first { $0.id == id }
    }
}
