//
//  TravelPhraseCatalog.swift
//  HanziPlus
//

import Foundation
import os

enum TravelPhraseCatalog {

    private static let logger = Logger(subsystem: "HanziPlus", category: "TravelPhraseCatalog")
    private static var cached: [TravelPhrase]?

    static func allPhrases() -> [TravelPhrase] {
        if let cached { return cached }

        guard let url = Bundle.main.url(forResource: "travel_phrases", withExtension: "json") else {
            logger.error("travel_phrases.json not found")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let phrases = try JSONDecoder().decode([TravelPhrase].self, from: data)
            cached = phrases
            return phrases
        } catch {
            logger.error("Failed to decode travel_phrases.json: \(error.localizedDescription)")
            return []
        }
    }

    static func phrases(in categoryID: String) -> [TravelPhrase] {
        let resolvedID = resolvedCategoryID(categoryID)
        return allPhrases().filter { $0.categoryID == resolvedID }
    }

    private static func resolvedCategoryID(_ categoryID: String) -> String {
        categoryID == "shopping" ? "shopping_mall" : categoryID
    }

    static func phrase(id: String) -> TravelPhrase? {
        allPhrases().first { $0.id == id }
    }

    static func search(_ query: String, in phrases: [TravelPhrase]? = nil) -> [TravelPhrase] {
        let normalized = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let source = phrases ?? allPhrases()
        guard !normalized.isEmpty else { return source }
        return source.filter { $0.searchableText.contains(normalized) }
    }

    static func tripEssentials() -> [TravelPhrase] {
        let preferredIDs = [
            "ess-hello",
            "ess-thank-you",
            "ess-toilet",
            "tr-taxi-address",
            "food-not-spicy",
            "food-allergy",
            "shop-alipay",
            "shop-wechat-pay",
            "net-wifi",
            "em-help"
        ]
        let byID = Dictionary(uniqueKeysWithValues: allPhrases().map { ($0.id, $0) })
        return preferredIDs.compactMap { byID[$0] }
    }

    static func count(in categoryID: String) -> Int {
        phrases(in: categoryID).count
    }

    static func previewPhrase(in categoryID: String) -> TravelPhrase? {
        phrases(in: categoryID).first
    }
}
