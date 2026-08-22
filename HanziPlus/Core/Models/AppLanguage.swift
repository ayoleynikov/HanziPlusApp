//
//  AppLanguage.swift
//  HanziPlus
//

import Foundation

/// Interface + content translation language preference.
/// Studying language is always Mandarin Chinese (zh-CN speech / Hanzi / pinyin).
enum AppLanguage: String, Codable, CaseIterable, Identifiable, Sendable {
    case system
    case english
    case russian
    case spanish
    case portugueseBrazil

    var id: String { rawValue }

    /// BCP-47 / Apple locale identifier used for UI String Catalog lookups.
    var localeIdentifier: String {
        switch self {
        case .system: Locale.current.identifier
        case .english: "en"
        case .russian: "ru"
        case .spanish: "es"
        case .portugueseBrazil: "pt-BR"
        }
    }

    /// Content translation dictionary key (`en`, `ru`, `es`, `pt-BR`).
    var contentCode: String {
        switch self {
        case .system:
            Self.resolveSystem().contentCode
        case .english: "en"
        case .russian: "ru"
        case .spanish: "es"
        case .portugueseBrazil: "pt-BR"
        }
    }

    var settingsTitleKey: String {
        switch self {
        case .system: "language.system"
        case .english: "language.english"
        case .russian: "language.russian"
        case .spanish: "language.spanish"
        case .portugueseBrazil: "language.portuguese_brazil"
        }
    }

    /// Resolve `.system` to a concrete supported language from preferred languages.
    static func resolveSystem(
        preferredLanguages: [String] = Locale.preferredLanguages
    ) -> AppLanguage {
        for raw in preferredLanguages {
            let normalized = raw.replacingOccurrences(of: "_", with: "-").lowercased()
            if normalized.hasPrefix("ru") { return .russian }
            if normalized.hasPrefix("es") { return .spanish }
            if normalized == "pt-br" || normalized.hasPrefix("pt-br") || normalized == "pt" || normalized.hasPrefix("pt-") {
                // Treat bare `pt` and `pt-BR` as Brazilian Portuguese per product decision.
                return .portugueseBrazil
            }
            if normalized.hasPrefix("en") { return .english }
        }
        return .english
    }

    /// Concrete language used for lookups (never `.system`).
    var resolved: AppLanguage {
        self == .system ? Self.resolveSystem() : self
    }

    var locale: Locale {
        Locale(identifier: resolved.localeIdentifier)
    }
}

enum ContentLanguageCode: String, CaseIterable, Sendable {
    case en
    case ru
    case es
    case ptBR = "pt-BR"

    init(appLanguage: AppLanguage) {
        switch appLanguage.resolved {
        case .system: self = .en
        case .english: self = .en
        case .russian: self = .ru
        case .spanish: self = .es
        case .portugueseBrazil: self = .ptBR
        }
    }
}
