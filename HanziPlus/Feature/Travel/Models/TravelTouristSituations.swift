//
//  TravelTouristSituations.swift
//  HanziPlus
//

import Foundation

enum TravelTouristSituations {

    /// Featured situations on the Travel hub grid.
    static let featuredCategoryIDs: [String] = [
        "airport",
        "taxi",
        "metro",
        "hotel",
        "shopping_mall",
        "food",
        "emergency",
        "essentials"
    ]

    /// Tourist-word stops between cities on the Journey route (one per gap, all unique).
    static let routeBetweenCities: [String] = [
        "airport",
        "taxi",
        "food",
        "hotel",
        "metro",
        "shopping_mall",
        "internet",
        "essentials",
        "emergency",
        "transport"
    ]

    /// Decorative hanzi seal on route stops between cities.
    static func routeSealCharacter(for categoryID: String) -> String {
        switch categoryID {
        case "airport": "机"
        case "taxi": "车"
        case "food": "食"
        case "hotel": "宿"
        case "metro": "铁"
        case "shopping_mall": "购"
        case "internet": "网"
        case "essentials": "用"
        case "emergency": "急"
        case "transport": "行"
        default: "游"
        }
    }
}
