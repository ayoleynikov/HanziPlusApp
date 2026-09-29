//
//  PathLocalizedText.swift
//  HanziPlus
//

import Foundation

/// Bilingual lesson copy stored as either a legacy plain string (Russian) or a locale map.
struct PathLocalizedText: Codable, Equatable, Hashable {

    private let values: [String: String]

    init(values: [String: String]) {
        self.values = values
    }

    init(legacyRussian value: String) {
        self.values = ["ru": value]
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
            values = trimmed.isEmpty ? [:] : ["ru": trimmed]
            return
        }
        values = try container.decode([String: String].self)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if values.count == 1, let only = values.first {
            try container.encode(only.value)
        } else {
            try container.encode(values)
        }
    }

    var isEmpty: Bool {
        values.values.allSatisfy { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }

    func localizedValue(language: ContentLanguageCode = LocalizedContent.currentLanguage) -> String {
        LocalizedContent.pick(
            from: values,
            code: language.rawValue,
            englishFallback: values["en"]
        )
    }

    func localizedValueOrNil(language: ContentLanguageCode = LocalizedContent.currentLanguage) -> String? {
        let value = localizedValue(language: language).trimmingCharacters(in: .whitespacesAndNewlines)
        guard !value.isEmpty else { return nil }
        if value.uppercased().hasPrefix("TODO") { return nil }
        return value
    }

    static func sanitized(_ raw: PathLocalizedText?) -> PathLocalizedText? {
        guard let raw, !raw.isEmpty else { return nil }
        if raw.values.values.contains(where: isPlaceholderMarker) {
            return nil
        }
        return raw
    }

    nonisolated private static func isPlaceholderMarker(_ value: String) -> Bool {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return false }
        let upper = trimmed.uppercased()
        if upper.hasPrefix("TODO") {
            let suffix = upper.dropFirst(4)
            return suffix.isEmpty || suffix.first == " " || suffix.first == ":" || suffix.first == ","
        }
        return upper.contains("TBD") || upper.contains("FIXME")
    }
}
