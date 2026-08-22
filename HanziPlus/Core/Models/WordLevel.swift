//
//  WordLevel.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct WordLevel: Hashable, Sendable {

    let fileName: String

    init(fileName: String) {
        self.fileName = fileName
    }

    init(studySet: StudySet) {
        self.fileName = studySet.fileName
    }

    var badgeTitle: String {
        SampleStudySets.studySet(fileName: fileName)?.title ?? fileName
    }

    var color: Color {
        SampleStudySets.studySet(fileName: fileName)?.color ?? .gray
    }

    static var allCases: [WordLevel] {
        SampleStudySets.all.map { WordLevel(studySet: $0) }
    }
}
