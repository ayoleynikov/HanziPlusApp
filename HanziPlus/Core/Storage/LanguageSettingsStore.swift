//
//  LanguageSettingsStore.swift
//  HanziPlus
//

import Foundation
import Observation
import SwiftUI

@Observable
final class LanguageSettingsStore {

    private let defaults = UserDefaults.standard
    private let storageKey = "languageSettings.preference.v1"

    var preference: AppLanguage {
        didSet {
            defaults.set(preference.rawValue, forKey: storageKey)
            syncContentLanguage()
        }
    }

    init() {
        if let raw = defaults.string(forKey: storageKey),
           let stored = AppLanguage(rawValue: raw) {
            preference = stored
        } else {
            preference = .system
        }
        syncContentLanguage()
    }

    /// Concrete language for UI + content (never `.system`).
    var effectiveLanguage: AppLanguage {
        preference.resolved
    }

    var locale: Locale {
        effectiveLanguage.locale
    }

    var contentCode: String {
        effectiveLanguage.contentCode
    }

    var contentLanguage: ContentLanguageCode {
        ContentLanguageCode(appLanguage: effectiveLanguage)
    }

    /// Token that changes when language changes — use with `.id` to refresh TabView labels.
    var refreshToken: String {
        "\(preference.rawValue)-\(effectiveLanguage.rawValue)"
    }

    private func syncContentLanguage() {
        LocalizedContent.currentLanguage = contentLanguage
    }
}
