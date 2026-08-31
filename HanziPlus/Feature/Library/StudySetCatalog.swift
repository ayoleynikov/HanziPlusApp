//
//  StudySetCatalog.swift
//  HanziPlus
//

import SwiftUI

struct StudySetSection: Identifiable, Equatable {

    let id: String
    let title: String
    let icon: String
    let emoji: String

    var localizedTitle: String {
        L10n.dynamic(title)
    }

    var displayTitle: String {
        "\(emoji) \(localizedTitle)"
    }
}

struct StudySetGroup: Identifiable {

    let id: String
    let title: String
    let emoji: String
    let sets: [StudySet]

    var localizedTitle: String {
        L10n.dynamic(title)
    }
}

enum StudySetCatalog {

    static func sections(for fileName: String) -> [StudySetSection] {
        switch fileName {
        case "travel": travelSections
        case "business": businessSections
        case "daily_life": dailyLifeSections
        case "food": foodSections
        case "culture": cultureSections
        case "technology": technologySections
        default: []
        }
    }

    static func section(fileName: String, id: String) -> StudySetSection? {
        sections(for: fileName).first { $0.id == id }
    }

    static let travelSections: [StudySetSection] = [
        StudySetSection(id: "essentials", title: "Travel Essentials", icon: "star.fill", emoji: "⭐"),
        StudySetSection(id: "airport", title: "Airport", icon: "airplane", emoji: "✈️"),
        StudySetSection(id: "hotel", title: "Hotel", icon: "bed.double.fill", emoji: "🏨"),
        StudySetSection(id: "transportation", title: "Transportation", icon: "tram.fill", emoji: "🚄"),
        StudySetSection(id: "restaurant", title: "Restaurant & Café", icon: "fork.knife", emoji: "🍜"),
        StudySetSection(id: "shopping", title: "Shopping", icon: "bag.fill", emoji: "🛍"),
        StudySetSection(id: "sightseeing", title: "Sightseeing", icon: "camera.fill", emoji: "🏛"),
        StudySetSection(id: "mobile", title: "Mobile & Internet", icon: "iphone", emoji: "📱"),
        StudySetSection(id: "money", title: "Money & Payments", icon: "creditcard.fill", emoji: "💳"),
        StudySetSection(id: "emergency", title: "Emergency", icon: "cross.case.fill", emoji: "🚨")
    ]

    static let businessSections: [StudySetSection] = [
        StudySetSection(id: "meetings", title: "Meetings", icon: "person.3.fill", emoji: "🤝"),
        StudySetSection(id: "email", title: "Email & Communication", icon: "envelope.fill", emoji: "📧"),
        StudySetSection(id: "sales", title: "Sales & Marketing", icon: "chart.line.uptrend.xyaxis", emoji: "📈"),
        StudySetSection(id: "manufacturing", title: "Manufacturing", icon: "gearshape.2.fill", emoji: "🏭"),
        StudySetSection(id: "logistics", title: "Logistics & Shipping", icon: "shippingbox.fill", emoji: "🚢"),
        StudySetSection(id: "finance", title: "Finance & Payments", icon: "yensign.circle.fill", emoji: "💰"),
        StudySetSection(id: "phone", title: "Phone Calls", icon: "phone.fill", emoji: "📞"),
        StudySetSection(id: "office", title: "Office", icon: "building.2.fill", emoji: "👔"),
        StudySetSection(id: "negotiations", title: "Negotiations", icon: "chart.bar.fill", emoji: "📊"),
        StudySetSection(id: "contracts", title: "Contracts", icon: "doc.text.fill", emoji: "📄")
    ]

    static let dailyLifeSections: [StudySetSection] = [
        StudySetSection(id: "greetings", title: "Greetings", icon: "hand.wave.fill", emoji: "👋"),
        StudySetSection(id: "family", title: "Family", icon: "figure.2.and.child.holdinghands", emoji: "👨‍👩‍👧"),
        StudySetSection(id: "home", title: "Home", icon: "house.fill", emoji: "🏠"),
        StudySetSection(id: "shopping", title: "Daily Shopping", icon: "cart.fill", emoji: "🛒"),
        StudySetSection(id: "weather", title: "Weather", icon: "cloud.sun.fill", emoji: "☀️"),
        StudySetSection(id: "time", title: "Time & Dates", icon: "calendar", emoji: "⏰"),
        StudySetSection(id: "emotions", title: "Emotions", icon: "face.smiling.fill", emoji: "😊"),
        StudySetSection(id: "clothing", title: "Clothing", icon: "tshirt.fill", emoji: "👕"),
        StudySetSection(id: "health", title: "Health", icon: "heart.fill", emoji: "💊"),
        StudySetSection(id: "social", title: "Social Life", icon: "party.popper.fill", emoji: "🎉")
    ]

    static let foodSections: [StudySetSection] = [
        StudySetSection(id: "fruits", title: "Fruits", icon: "leaf.fill", emoji: "🍎"),
        StudySetSection(id: "vegetables", title: "Vegetables", icon: "carrot.fill", emoji: "🥬"),
        StudySetSection(id: "meat", title: "Meat", icon: "fork.knife", emoji: "🥩"),
        StudySetSection(id: "seafood", title: "Seafood", icon: "fish.fill", emoji: "🐟"),
        StudySetSection(id: "cuisine", title: "Chinese Cuisine", icon: "takeoutbag.and.cup.and.straw.fill", emoji: "🍚"),
        StudySetSection(id: "street_food", title: "Street Food", icon: "storefront.fill", emoji: "🥟"),
        StudySetSection(id: "desserts", title: "Desserts", icon: "birthday.cake.fill", emoji: "🍰"),
        StudySetSection(id: "coffee", title: "Coffee", icon: "cup.and.saucer.fill", emoji: "☕"),
        StudySetSection(id: "tea", title: "Tea", icon: "mug.fill", emoji: "🍵"),
        StudySetSection(id: "drinks", title: "Drinks", icon: "waterbottle.fill", emoji: "🥤")
    ]

    static let cultureSections: [StudySetSection] = [
        StudySetSection(id: "cny", title: "Chinese New Year", icon: "sparkles", emoji: "🧧"),
        StudySetSection(id: "dragon_boat", title: "Dragon Boat Festival", icon: "sailboat.fill", emoji: "🐉"),
        StudySetSection(id: "lantern", title: "Lantern Festival", icon: "light.max", emoji: "🏮"),
        StudySetSection(id: "mid_autumn", title: "Mid-Autumn Festival", icon: "moon.fill", emoji: "🌕"),
        StudySetSection(id: "pandas", title: "Pandas", icon: "pawprint.fill", emoji: "🐼"),
        StudySetSection(id: "tea_culture", title: "Tea Culture", icon: "leaf.circle.fill", emoji: "🍵"),
        StudySetSection(id: "landmarks", title: "Famous Landmarks", icon: "building.columns.fill", emoji: "🏯"),
        StudySetSection(id: "zodiac", title: "Chinese Zodiac", icon: "circle.grid.cross.fill", emoji: "🐲"),
        StudySetSection(id: "arts", title: "Traditional Arts", icon: "paintbrush.fill", emoji: "🎭"),
        StudySetSection(id: "kungfu", title: "Kung Fu", icon: "figure.martial.arts", emoji: "🥋")
    ]

    static let technologySections: [StudySetSection] = [
        StudySetSection(id: "smartphones", title: "Smartphones", icon: "iphone", emoji: "📱"),
        StudySetSection(id: "computers", title: "Computers", icon: "laptopcomputer", emoji: "💻"),
        StudySetSection(id: "internet", title: "Internet", icon: "globe", emoji: "🌐"),
        StudySetSection(id: "ai", title: "Artificial Intelligence", icon: "brain.head.profile", emoji: "🤖"),
        StudySetSection(id: "social_media", title: "Social Media", icon: "bubble.left.and.bubble.right.fill", emoji: "💬"),
        StudySetSection(id: "online_shopping", title: "Online Shopping", icon: "bag.circle.fill", emoji: "🛍"),
        StudySetSection(id: "delivery", title: "Delivery Apps", icon: "scooter", emoji: "📦"),
        StudySetSection(id: "gaming", title: "Gaming", icon: "gamecontroller.fill", emoji: "🎮"),
        StudySetSection(id: "smart_devices", title: "Smart Devices", icon: "applewatch", emoji: "⌚"),
        StudySetSection(id: "electronics", title: "Electronics", icon: "bolt.fill", emoji: "🔋")
    ]
}

enum SectionedVocabulary {

    static func words(in section: StudySetSection, fileName: String) -> [Word] {
        WordLoader.load(fileName: fileName)
            .filter { $0.section == section.id }
    }

    static func wordCount(in section: StudySetSection, fileName: String) -> Int {
        words(in: section, fileName: fileName).count
    }

    static func learnedCount(
        in section: StudySetSection,
        fileName: String,
        store: LearnedWordsStore
    ) -> Int {
        words(in: section, fileName: fileName)
            .filter { store.isLearned(fileName: fileName, hanzi: $0.hanzi) }
            .count
    }

    static func progress(
        in section: StudySetSection,
        fileName: String,
        store: LearnedWordsStore
    ) -> Double {
        let total = wordCount(in: section, fileName: fileName)
        guard total > 0 else { return 0 }
        return Double(learnedCount(in: section, fileName: fileName, store: store)) / Double(total)
    }

    static func isComplete(
        in section: StudySetSection,
        fileName: String,
        store: LearnedWordsStore
    ) -> Bool {
        let total = wordCount(in: section, fileName: fileName)
        guard total > 0 else { return false }
        return learnedCount(in: section, fileName: fileName, store: store) >= total
    }

    static func totalWordCount(fileName: String) -> Int {
        WordLoader.load(fileName: fileName).count
    }

    static func totalLearnedCount(fileName: String, store: LearnedWordsStore) -> Int {
        store.learnedCount(for: fileName)
    }

    static func sessionKey(fileName: String, section: StudySetSection) -> String {
        "\(fileName):\(section.id)"
    }

    static func parseSessionKey(_ key: String) -> (fileName: String, sectionID: String)? {
        let parts = key.split(separator: ":", maxSplits: 1).map(String.init)
        guard parts.count == 2 else { return nil }
        return (parts[0], parts[1])
    }
}

extension StudySet {

    var hasSections: Bool {
        !StudySetCatalog.sections(for: fileName).isEmpty
    }
}
