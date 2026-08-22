//
//  SampleStudySets.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

enum SampleStudySets {

    static let hsk1 = StudySet(
        title: "HSK 1",
        subtitle: "Beginner vocabulary",
        fileName: "hsk1",
        icon: "book.fill",
        color: .blue
    )

    static let hsk2 = StudySet(
        title: "HSK 2",
        subtitle: "Elementary vocabulary",
        fileName: "hsk2",
        icon: "books.vertical.fill",
        color: .green
    )

    static let hsk3 = StudySet(
        title: "HSK 3",
        subtitle: "Intermediate vocabulary",
        fileName: "hsk3",
        icon: "3.circle.fill",
        color: .purple
    )

    static let travel = StudySet(
        title: "Travel",
        subtitle: "Essential travel phrases",
        fileName: "travel",
        icon: "airplane",
        color: .orange
    )

    static let business = StudySet(
        title: "Business Chinese",
        subtitle: "Professional workplace vocabulary",
        fileName: "business",
        icon: "briefcase.fill",
        color: .indigo
    )

    static let dailyLife = StudySet(
        title: "Daily Life",
        subtitle: "Everyday conversation essentials",
        fileName: "daily_life",
        icon: "heart.fill",
        color: .pink
    )

    static let food = StudySet(
        title: "Food & Drinks",
        subtitle: "Chinese cuisine and beverages",
        fileName: "food",
        icon: "fork.knife",
        color: .red
    )

    static let culture = StudySet(
        title: "Chinese Culture",
        subtitle: "Festivals, traditions, and heritage",
        fileName: "culture",
        icon: "sparkles",
        color: .yellow
    )

    static let technology = StudySet(
        title: "Technology",
        subtitle: "Digital life and modern tech",
        fileName: "technology",
        icon: "desktopcomputer",
        color: .cyan
    )

    static let groups: [StudySetGroup] = [
        StudySetGroup(id: "hsk", title: "HSK", emoji: "🎓", sets: [hsk1, hsk2, hsk3]),
        StudySetGroup(id: "travel", title: "Travel", emoji: "✈️", sets: [travel]),
        StudySetGroup(id: "business", title: "Business Chinese", emoji: "💼", sets: [business]),
        StudySetGroup(id: "daily_life", title: "Daily Life", emoji: "❤️", sets: [dailyLife]),
        StudySetGroup(id: "food", title: "Food & Drinks", emoji: "🍜", sets: [food]),
        StudySetGroup(id: "culture", title: "Chinese Culture", emoji: "🏮", sets: [culture]),
        StudySetGroup(id: "technology", title: "Technology", emoji: "💻", sets: [technology])
    ]

    static let all: [StudySet] = groups.flatMap(\.sets)

    static func studySet(fileName: String) -> StudySet? {
        all.first { $0.fileName == fileName }
    }
}
