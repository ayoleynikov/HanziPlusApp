//
//  StudySet.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct StudySet: Identifiable {

    let id = UUID()

    let title: String
    let subtitle: String
    let fileName: String

    let icon: String
    let color: Color
}

extension StudySet {

    var name: String { localizedTitle }

    var localizedTitle: String {
        switch fileName {
        case "hsk1": L10n.string( "catalog.set.hsk1")
        case "hsk2": L10n.string( "catalog.set.hsk2")
        case "hsk3": L10n.string( "catalog.set.hsk3")
        case "travel": L10n.string( "catalog.set.travel")
        case "business": L10n.string( "catalog.set.business")
        case "daily_life": L10n.string( "catalog.set.daily_life")
        case "food": L10n.string( "catalog.set.food")
        case "culture": L10n.string( "catalog.set.culture")
        case "technology": L10n.string( "catalog.set.technology")
        case "path_course": L10n.string( "catalog.set.path_course")
        default: title
        }
    }

    var localizedSubtitle: String {
        switch fileName {
        case "hsk1": L10n.string( "catalog.set.hsk1.subtitle")
        case "hsk2": L10n.string( "catalog.set.hsk2.subtitle")
        case "hsk3": L10n.string( "catalog.set.hsk3.subtitle")
        case "travel": L10n.string( "catalog.set.travel.subtitle")
        case "business": L10n.string( "catalog.set.business.subtitle")
        case "daily_life": L10n.string( "catalog.set.daily_life.subtitle")
        case "food": L10n.string( "catalog.set.food.subtitle")
        case "culture": L10n.string( "catalog.set.culture.subtitle")
        case "technology": L10n.string( "catalog.set.technology.subtitle")
        case "path_course": L10n.string( "catalog.set.path_course.subtitle")
        default: subtitle
        }
    }

    static let allCases: [StudySet] = [
        StudySet(
            title: "HSK 1",
            subtitle: "Beginner",
            fileName: "hsk1",
            icon: "1.circle.fill",
            color: .blue
        ),
        StudySet(
            title: "HSK 2",
            subtitle: "Elementary",
            fileName: "hsk2",
            icon: "2.circle.fill",
            color: .green
        ),
        StudySet(
            title: "HSK 3",
            subtitle: "Intermediate",
            fileName: "hsk3",
            icon: "3.circle.fill",
            color: .orange
        ),
        StudySet(
            title: "Travel",
            subtitle: "Travel Chinese",
            fileName: "travel",
            icon: "airplane.circle.fill",
            color: .purple
        )
    ]
}
