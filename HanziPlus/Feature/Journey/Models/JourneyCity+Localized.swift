//
//  JourneyCity+Localized.swift
//  HanziPlus
//

import Foundation

extension JourneyCity {
    var localizedName: String {
        L10n.dynamic("journey.city.\(id).name")
    }

    var localizedProvince: String {
        L10n.dynamic("journey.city.\(id).province")
    }

    var localizedPopulation: String {
        L10n.dynamic("journey.city.\(id).population")
    }

    var localizedIntroduction: String {
        L10n.dynamic("journey.city.\(id).introduction")
    }

    var localizedFamousFor: String {
        L10n.dynamic("journey.city.\(id).famousFor")
    }

    var localizedBestSeason: String {
        L10n.dynamic("journey.city.\(id).bestSeason")
    }

    var localizedLocalFood: String {
        L10n.dynamic("journey.city.\(id).localFood")
    }

    var localizedSouvenirName: String {
        L10n.dynamic("journey.city.\(id).souvenirName")
    }

    var localizedAchievementName: String {
        L10n.dynamic("journey.city.\(id).localAchievement")
    }

    var localizedMiniTitle: String {
        L10n.dynamic("journey.city.\(id).mini.title")
    }

    var localizedMiniInstruction: String {
        L10n.dynamic("journey.city.\(id).mini.instruction")
    }
}

extension JourneyFact {
    var localizedText: String {
        L10n.dynamic("journey.fact.\(id)")
    }
}

extension JourneyAttraction {
    var localizedName: String {
        L10n.dynamic("journey.attraction.\(id).name")
    }

    var localizedDescription: String {
        L10n.dynamic("journey.attraction.\(id).description")
    }

    var localizedDetail: String {
        let key = "journey.attraction.\(id).detail"
        let detail = L10n.dynamic(key)
        guard detail != key else { return localizedDescription }
        return detail
    }

    var localizedTip: String {
        let key = "journey.attraction.\(id).tip"
        let tip = L10n.dynamic(key)
        guard tip != key else { return L10n.string("journey.attraction.tip_fallback") }
        return tip
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
