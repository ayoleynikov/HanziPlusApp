//
//  L10n.swift
//  HanziPlus
//

import Foundation
import SwiftUI

enum L10n {

    static func string(_ key: String.LocalizationValue, locale: Locale? = nil) -> String {
        if let locale {
            return String(localized: key, locale: locale)
        }
        return String(localized: key)
    }

    static func words(_ count: Int) -> String {
        String(localized: "plural.words \(count)")
    }

    static func days(_ count: Int) -> String {
        String(localized: "plural.days \(count)")
    }

    static func daysUntilTrip(_ count: Int) -> String {
        String(localized: "plural.days_until_trip \(count)")
    }

    static func minutes(_ count: Int) -> String {
        String(localized: "plural.minutes \(count)")
    }

    static func phrases(_ count: Int) -> String {
        String(localized: "plural.phrases \(count)")
    }

    static func xp(_ count: Int) -> String {
        String(localized: "plural.xp \(count)")
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
