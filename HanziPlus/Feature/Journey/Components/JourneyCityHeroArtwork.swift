//
//  JourneyCityHeroArtwork.swift
//  HanziPlus
//

import SwiftUI

struct JourneyCityHeroArtwork: View {
    let city: JourneyCity

    private var heroStyle: JourneyAttractionVisualStyle {
        switch city.id {
        case "beijing": .imperialPalace
        case "xian": .terracottaArmy
        case "chengdu": .wildlifePark
        case "guiyang": .forestPark
        case "guilin": .karstRiver
        case "shanghai": .colonialWaterfront
        case "hangzhou": .scenicLake
        case "suzhou": .classicalGarden
        case "harbin": .iceSculpture
        case "guangzhou": .modernTower
        case "shenzhen": .skylineSceneStyle
        case "hongkong": .harborPeak
        default: .scenicLake
        }
    }

    var body: some View {
        JourneyAttractionArtwork(
            style: heroStyle,
            tint: city.theme.primary,
            height: 240,
            cornerRadius: AppRadius.studyCard
        )
        .opacity(0.42)
        .allowsHitTesting(false)
    }
}

private extension JourneyAttractionVisualStyle {
    static var skylineSceneStyle: JourneyAttractionVisualStyle { .modernTower }
}
