//
//  JourneyCityContent.swift
//  HanziPlus
//

import SwiftUI

struct JourneyFact: Identifiable, Equatable {
    let id: String
    let icon: String
    let text: String
}

struct JourneyAttraction: Identifiable, Equatable {
    let id: String
    let name: String
    let emoji: String
    let description: String
}

struct JourneyVocabularyWord: Identifiable, Equatable {
    let id: String
    let hanzi: String
    let pinyin: String
    let english: String
    let translations: [String: String]?

    init(
        id: String,
        hanzi: String,
        pinyin: String,
        english: String,
        translations: [String: String]? = nil
    ) {
        self.id = id
        self.hanzi = hanzi
        self.pinyin = pinyin
        self.english = english
        self.translations = translations
    }
}

struct JourneyMiniActivity: Equatable {
    let title: String
    let instruction: String
    let icon: String
    let targetEmoji: String
    let xpReward: Int
}

struct JourneyColorTheme: Equatable {
    let primary: Color
    let secondary: Color
    let heroGradient: [Color]

    static func == (lhs: JourneyColorTheme, rhs: JourneyColorTheme) -> Bool {
        lhs.primary == rhs.primary
            && lhs.secondary == rhs.secondary
            && lhs.heroGradient == rhs.heroGradient
    }
}

extension JourneyCity {
    var accentColor: Color { theme.primary }

    static func make(
        id: String,
        name: String,
        emoji: String,
        province: String,
        population: String,
        introduction: String,
        famousFor: String,
        bestSeason: String,
        localFood: String,
        culturalFact: String,
        localAchievement: String,
        souvenirEmoji: String,
        souvenirName: String,
        travelCollectible: String,
        theme: JourneyColorTheme,
        facts: [JourneyFact],
        attractions: [JourneyAttraction],
        vocabulary: [JourneyVocabularyWord],
        miniActivity: JourneyMiniActivity,
        requirements: CityRequirements
    ) -> JourneyCity {
        JourneyCity(
            id: id,
            name: name,
            emoji: emoji,
            province: province,
            population: population,
            introduction: introduction,
            famousFor: famousFor,
            bestSeason: bestSeason,
            localFood: localFood,
            culturalFact: culturalFact,
            localAchievement: localAchievement,
            souvenirEmoji: souvenirEmoji,
            souvenirName: souvenirName,
            travelCollectible: travelCollectible,
            theme: theme,
            facts: facts,
            attractions: attractions,
            vocabulary: vocabulary,
            miniActivity: miniActivity,
            requirements: requirements
        )
    }
}
