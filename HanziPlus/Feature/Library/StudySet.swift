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

    var name: String {
        title
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
