//
//  JourneyCity+Localized.swift
//  HanziPlus
//

import Foundation

extension JourneyCity {
    var localizedName: String {
        String(localized: String.LocalizationValue("journey.city.\(id).name"))
    }

    var localizedProvince: String {
        String(localized: String.LocalizationValue("journey.city.\(id).province"))
    }

    var localizedPopulation: String {
        String(localized: String.LocalizationValue("journey.city.\(id).population"))
    }

    var localizedIntroduction: String {
        String(localized: String.LocalizationValue("journey.city.\(id).introduction"))
    }

    var localizedFamousFor: String {
        String(localized: String.LocalizationValue("journey.city.\(id).famousFor"))
    }

    var localizedBestSeason: String {
        String(localized: String.LocalizationValue("journey.city.\(id).bestSeason"))
    }

    var localizedLocalFood: String {
        String(localized: String.LocalizationValue("journey.city.\(id).localFood"))
    }

    var localizedSouvenirName: String {
        String(localized: String.LocalizationValue("journey.city.\(id).souvenirName"))
    }

    var localizedAchievementName: String {
        String(localized: String.LocalizationValue("journey.city.\(id).localAchievement"))
    }

    var localizedMiniTitle: String {
        String(localized: String.LocalizationValue("journey.city.\(id).mini.title"))
    }

    var localizedMiniInstruction: String {
        String(localized: String.LocalizationValue("journey.city.\(id).mini.instruction"))
    }
}

extension JourneyVocabularyWord {
    var localizedMeaning: String {
        LocalizedContent.pick(
            from: translations,
            code: LocalizedContent.currentLanguage.rawValue,
            englishFallback: english
        )
    }
}
