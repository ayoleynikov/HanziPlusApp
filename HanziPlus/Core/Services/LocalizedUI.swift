//
//  LocalizedUI.swift
//  HanziPlus
//

import Foundation
import Observation

/// Observable runtime localization state. SwiftUI tracks reads made by `L10n`
/// while evaluating a view, so changing the language refreshes visible screens.
@Observable
final class LocalizationRuntime {
    static let shared = LocalizationRuntime()

    var uiLocale = Locale(identifier: "en")
    var contentLanguage: ContentLanguageCode = .en

    private init() {}
}

enum LocalizedUI {
    static var currentLocale: Locale {
        get { LocalizationRuntime.shared.uiLocale }
        set { LocalizationRuntime.shared.uiLocale = newValue }
    }

    /// Bundle for the language selected inside the app. `String(localized:locale:)`
    /// formats values with the supplied locale, but Bundle still chooses its own
    /// preferred localization. Resolving the concrete `.lproj` bundle makes the
    /// in-app language independent from the device language.
    static var currentBundle: Bundle {
        bundle(for: currentLocale)
    }

    static func bundle(for locale: Locale) -> Bundle {
        let normalized = locale.identifier.replacingOccurrences(of: "_", with: "-")
        let languageCode: String

        if normalized.lowercased().hasPrefix("pt") {
            languageCode = "pt-BR"
        } else if normalized.lowercased().hasPrefix("ru") {
            languageCode = "ru"
        } else if normalized.lowercased().hasPrefix("es") {
            languageCode = "es"
        } else {
            languageCode = "en"
        }

        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: path)
        else {
            return .main
        }
        return bundle
    }
}
