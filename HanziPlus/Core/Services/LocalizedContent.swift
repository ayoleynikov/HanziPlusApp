//
//  LocalizedContent.swift
//  HanziPlus
//

import Foundation

/// Shared helpers for bilingual/multilingual content dictionaries in JSON.
enum LocalizedContent {

    static let supportedCodes = ["en", "ru", "es", "pt-BR"]

    /// Updated by `LanguageSettingsStore` so models/view-models can resolve meanings
    /// without threading Environment through every call site. The backing state is
    /// observable, which makes visible content refresh immediately in SwiftUI.
    static var currentLanguage: ContentLanguageCode {
        get { LocalizationRuntime.shared.contentLanguage }
        set { LocalizationRuntime.shared.contentLanguage = newValue }
    }

    /// Pick translation for `code`, falling back to English then first non-empty value.
    static func pick(
        from translations: [String: String]?,
        code: String,
        englishFallback: String?
    ) -> String {
        if let value = translations?[code]?.trimmingCharacters(in: .whitespacesAndNewlines),
           !value.isEmpty {
            return value
        }
        if let en = translations?["en"]?.trimmingCharacters(in: .whitespacesAndNewlines),
           !en.isEmpty {
            return en
        }
        if let englishFallback, !englishFallback.isEmpty {
            return englishFallback
        }
        if let first = translations?.values
            .map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
            .first(where: { !$0.isEmpty }) {
            return first
        }
        return englishFallback ?? ""
    }

    static func searchableBlob(
        translations: [String: String]?,
        englishFallback: String?,
        extras: [String] = []
    ) -> String {
        var parts = extras
        if let translations {
            parts.append(contentsOf: translations.values)
        }
        if let englishFallback {
            parts.append(englishFallback)
        }
        return parts
            .map { $0.lowercased() }
            .joined(separator: " ")
    }
}
