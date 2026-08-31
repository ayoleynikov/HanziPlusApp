//
//  JourneyAttractionVisualStyle.swift
//  HanziPlus
//

import SwiftUI

enum JourneyAttractionEra: String, Equatable {
    case classic
    case modern
    case timeless

    var localizedLabel: String {
        switch self {
        case .classic: L10n.string("journey.attraction.era.classic")
        case .modern: L10n.string("journey.attraction.era.modern")
        case .timeless: L10n.string("journey.attraction.era.timeless")
        }
    }
}

enum JourneyAttractionVisualStyle: String, Equatable {
    case imperialPalace
    case greatWall
    case sacredTemple
    case localCuisine
    case artDistrict
    case terracottaArmy
    case ancientFortress
    case nightMarket
    case pagoda
    case wildlifePark
    case ancientStreet
    case shrine
    case riversidePavilion
    case forestPark
    case ancientTown
    case karstRiver
    case countrysideTown
    case limestoneCave
    case riceTerraces
    case colonialWaterfront
    case modernTower
    case classicalGarden
    case shoppingAvenue
    case scenicLake
    case teaHills
    case forestTemple
    case canalTown
    case heritageMuseum
    case iceSculpture
    case europeanStreet
    case cathedral
    case mountainView
    case waterfrontPromenade
    case artVillage
    case creativeDistrict
    case harborPeak
    case historicFerry
    case modernArchitecture
    case modernCBD
    case artMuseum
    case modernLakefront
    case modernRetail
    case nightLightsDistrict
}

enum JourneyAttractionVisualCatalog {
    static func style(for id: String) -> JourneyAttractionVisualStyle {
        styles[id] ?? .scenicLake
    }

    static func era(for id: String) -> JourneyAttractionEra {
        eras[id] ?? .classic
    }

    private static let styles: [String: JourneyAttractionVisualStyle] = [
        "bj-a1": .imperialPalace, "bj-a2": .greatWall, "bj-a3": .sacredTemple,
        "bj-a4": .localCuisine, "bj-a5": .artDistrict,
        "xa-a1": .terracottaArmy, "xa-a2": .ancientFortress, "xa-a3": .nightMarket,
        "xa-a4": .pagoda, "xa-a5": .nightLightsDistrict,
        "cd-a1": .wildlifePark, "cd-a2": .ancientStreet, "cd-a3": .localCuisine,
        "cd-a4": .shrine, "cd-a5": .modernRetail,
        "gy-a1": .riversidePavilion, "gy-a2": .forestPark, "gy-a3": .ancientTown,
        "gy-a4": .forestPark, "gy-a5": .artMuseum,
        "gl-a1": .karstRiver, "gl-a2": .countrysideTown, "gl-a3": .limestoneCave,
        "gl-a4": .riceTerraces, "gl-a5": .modernLakefront,
        "sh-a1": .colonialWaterfront, "sh-a2": .modernTower, "sh-a3": .classicalGarden,
        "sh-a4": .shoppingAvenue, "sh-a5": .artMuseum,
        "hz-a1": .scenicLake, "hz-a2": .pagoda, "hz-a3": .teaHills,
        "hz-a4": .forestTemple, "hz-a5": .modernCBD,
        "sz-a1": .classicalGarden, "sz-a2": .pagoda, "sz-a3": .canalTown,
        "sz-a4": .heritageMuseum, "sz-a5": .modernLakefront,
        "hb-a1": .iceSculpture, "hb-a2": .europeanStreet, "hb-a3": .cathedral,
        "hb-a4": .iceSculpture, "hb-a5": .modernArchitecture,
        "gz-a1": .modernTower, "gz-a2": .heritageMuseum, "gz-a3": .europeanStreet,
        "gz-a4": .mountainView, "gz-a5": .modernCBD,
        "szh-a1": .modernTower, "szh-a2": .waterfrontPromenade, "szh-a3": .artVillage,
        "szh-a4": .creativeDistrict, "szh-a5": .artMuseum,
        "hk-a1": .harborPeak, "hk-a2": .historicFerry, "hk-a3": .nightMarket,
        "hk-a4": .localCuisine, "hk-a5": .artMuseum
    ]

    private static let eras: [String: JourneyAttractionEra] = [
        "bj-a1": .classic, "bj-a2": .classic, "bj-a3": .classic,
        "bj-a4": .timeless, "bj-a5": .modern,
        "xa-a1": .classic, "xa-a2": .classic, "xa-a3": .timeless,
        "xa-a4": .classic, "xa-a5": .modern,
        "cd-a1": .timeless, "cd-a2": .classic, "cd-a3": .timeless,
        "cd-a4": .classic, "cd-a5": .modern,
        "gy-a1": .classic, "gy-a2": .timeless, "gy-a3": .classic,
        "gy-a4": .timeless, "gy-a5": .modern,
        "gl-a1": .classic, "gl-a2": .timeless, "gl-a3": .classic,
        "gl-a4": .classic, "gl-a5": .modern,
        "sh-a1": .classic, "sh-a2": .modern, "sh-a3": .classic,
        "sh-a4": .modern, "sh-a5": .modern,
        "hz-a1": .classic, "hz-a2": .classic, "hz-a3": .classic,
        "hz-a4": .classic, "hz-a5": .modern,
        "sz-a1": .classic, "sz-a2": .classic, "sz-a3": .classic,
        "sz-a4": .classic, "sz-a5": .modern,
        "hb-a1": .timeless, "hb-a2": .classic, "hb-a3": .classic,
        "hb-a4": .timeless, "hb-a5": .modern,
        "gz-a1": .modern, "gz-a2": .classic, "gz-a3": .classic,
        "gz-a4": .timeless, "gz-a5": .modern,
        "szh-a1": .modern, "szh-a2": .modern, "szh-a3": .timeless,
        "szh-a4": .modern, "szh-a5": .modern,
        "hk-a1": .classic, "hk-a2": .classic, "hk-a3": .timeless,
        "hk-a4": .timeless, "hk-a5": .modern
    ]
}

extension JourneyAttraction {
    var visualStyle: JourneyAttractionVisualStyle {
        JourneyAttractionVisualCatalog.style(for: id)
    }

    var era: JourneyAttractionEra {
        JourneyAttractionVisualCatalog.era(for: id)
    }
}
