//
//  L10n.swift
//  HanziPlus
//

import Foundation
import SwiftUI

enum L10n {

    /// Resolve a String Catalog key using the in-app UI language (not the system locale).
    static func string(_ key: String.LocalizationValue) -> String {
        String(
            localized: key,
            bundle: LocalizedUI.currentBundle,
            locale: LocalizedUI.currentLocale
        )
    }

    static func string(_ key: String.LocalizationValue, locale: Locale) -> String {
        String(localized: key, bundle: LocalizedUI.bundle(for: locale), locale: locale)
    }

    /// Resolve a key assembled at runtime. Keeping interpolation out of
    /// `String.LocalizationValue` prevents it from becoming a `%@` format key.
    static func dynamic(_ key: String) -> String {
        string(String.LocalizationValue(key))
    }

    static func abbreviatedDate(_ date: Date) -> String {
        date.formatted(
            Date.FormatStyle(date: .abbreviated, time: .omitted)
                .locale(LocalizedUI.currentLocale)
        )
    }

    static func words(_ count: Int) -> String {
        string("plural.words \(count)")
    }

    static func days(_ count: Int) -> String {
        string("plural.days \(count)")
    }

    static func daysUntilTrip(_ count: Int) -> String {
        string("plural.days_until_trip \(count)")
    }

    static func minutes(_ count: Int) -> String {
        string("plural.minutes \(count)")
    }

    static func phrases(_ count: Int) -> String {
        string("plural.phrases \(count)")
    }

    static func xp(_ count: Int) -> String {
        string("plural.xp \(count)")
    }

    /// Formats an integer percent value (0–100) using the in-app locale.
    static func percent(_ value: Int, locale: Locale = LocalizedUI.currentLocale) -> String {
        let number = NSNumber(value: Double(value) / 100.0)
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        formatter.locale = locale
        return formatter.string(from: number) ?? "\(value)%"
    }

    /// Inserts a pre-formatted value into a localized template containing `%@`.
    static func placeholder(_ key: String.LocalizationValue, _ value: String) -> String {
        let format = string(key)
        return String(format: format, locale: LocalizedUI.currentLocale, value)
    }
}

extension Text {
    /// String Catalog text resolved with the in-app UI language.
    init(l10n key: String.LocalizationValue) {
        self.init(L10n.string(key))
    }
}

private struct ContentLanguageKey: EnvironmentKey {
    static let defaultValue: ContentLanguageCode = .en
}

extension EnvironmentValues {
    var contentLanguage: ContentLanguageCode {
        get { self[ContentLanguageKey.self] }
        set { self[ContentLanguageKey.self] = newValue }
    }
}
