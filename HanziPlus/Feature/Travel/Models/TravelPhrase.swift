//
//  TravelPhrase.swift
//  HanziPlus
//

import Foundation

struct TravelPhraseReply: Codable, Hashable, Identifiable {
    var id: String { "\(chinese)-\(english)" }
    let chinese: String
    let pinyin: String
    let english: String
}

struct TravelPhrase: Codable, Hashable, Identifiable {
    let id: String
    let categoryID: String
    let simplifiedChinese: String
    let pinyin: String
    let english: String
    let usageNote: String?
    let tags: [String]
    let isEmergency: Bool
    let possibleReplies: [TravelPhraseReply]?

    var searchableText: String {
        ([
            simplifiedChinese,
            pinyin,
            english,
            usageNote ?? "",
            categoryID
        ] + tags)
        .joined(separator: " ")
        .lowercased()
    }
}

struct TravelPhraseCategory: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
    /// Semantic accent key used by views (`orange`, `blue`, `red`, …).
    let accentName: String
}

enum TravelPhraseCategories {
    static let all: [TravelPhraseCategory] = [
        TravelPhraseCategory(
            id: "essentials",
            title: "Essentials",
            subtitle: "Polite basics you use every day",
            icon: "star.fill",
            accentName: "orange"
        ),
        TravelPhraseCategory(
            id: "airport",
            title: "Airport",
            subtitle: "Check-in, boarding, and baggage",
            icon: "airplane",
            accentName: "blue"
        ),
        TravelPhraseCategory(
            id: "transport",
            title: "Transport",
            subtitle: "Taxi, metro, trains, and directions",
            icon: "tram.fill",
            accentName: "indigo"
        ),
        TravelPhraseCategory(
            id: "hotel",
            title: "Hotel",
            subtitle: "Check-in, rooms, and booking issues",
            icon: "bed.double.fill",
            accentName: "purple"
        ),
        TravelPhraseCategory(
            id: "food",
            title: "Food",
            subtitle: "Ordering, allergies, and the bill",
            icon: "fork.knife",
            accentName: "pink"
        ),
        TravelPhraseCategory(
            id: "shopping",
            title: "Shopping & Payment",
            subtitle: "Prices, bargaining, and how to pay",
            icon: "bag.fill",
            accentName: "teal"
        ),
        TravelPhraseCategory(
            id: "internet",
            title: "Internet & Mobile",
            subtitle: "Wi-Fi, SIM, and QR codes",
            icon: "iphone",
            accentName: "green"
        ),
        TravelPhraseCategory(
            id: "emergency",
            title: "Emergency",
            subtitle: "Police, hospital, and lost passport",
            icon: "cross.case.fill",
            accentName: "red"
        )
    ]

    static func category(id: String) -> TravelPhraseCategory? {
        all.first { $0.id == id }
    }
}
