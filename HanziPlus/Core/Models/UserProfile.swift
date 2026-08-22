//
//  UserProfile.swift
//  HanziPlus
//

import Foundation
import SwiftUI

enum PrimaryGoal: String, Codable, CaseIterable, Identifiable {
    case learnChinese
    case travelToChina
    case both

    var id: String { rawValue }

    var title: String {
        switch self {
        case .learnChinese: "Learn Chinese"
        case .travelToChina: "Travel to China"
        case .both: "Both"
        }
    }

    var subtitle: String {
        switch self {
        case .learnChinese: "Build vocabulary with HSK and everyday topics"
        case .travelToChina: "Focus on phrases you’ll use on the trip"
        case .both: "Balance study with practical travel prep"
        }
    }

    var icon: String {
        switch self {
        case .learnChinese: "book.fill"
        case .travelToChina: "airplane"
        case .both: "globe.asia.australia.fill"
        }
    }

    var includesTravel: Bool {
        self == .travelToChina || self == .both
    }

    var includesLearning: Bool {
        self == .learnChinese || self == .both
    }
}

enum ChineseLevel: String, Codable, CaseIterable, Identifiable {
    case completeBeginner
    case beginner
    case intermediate

    var id: String { rawValue }

    var title: String {
        switch self {
        case .completeBeginner: "Complete Beginner"
        case .beginner: "Beginner"
        case .intermediate: "Intermediate"
        }
    }

    var subtitle: String {
        switch self {
        case .completeBeginner: "Starting from zero"
        case .beginner: "Know a few basics"
        case .intermediate: "Ready for HSK 2–3"
        }
    }

    var icon: String {
        switch self {
        case .completeBeginner: "1.circle.fill"
        case .beginner: "2.circle.fill"
        case .intermediate: "3.circle.fill"
        }
    }

    var recommendedStudySet: StudySet {
        switch self {
        case .completeBeginner, .beginner:
            SampleStudySets.hsk1
        case .intermediate:
            SampleStudySets.hsk2
        }
    }
}

enum DailyMinutes: Int, Codable, CaseIterable, Identifiable {
    case five = 5
    case ten = 10
    case fifteen = 15

    var id: Int { rawValue }

    var title: String { "\(rawValue) minutes" }

    var lessonWordCount: Int {
        switch self {
        case .five: 5
        case .ten: 8
        case .fifteen: 12
        }
    }

    var subtitle: String {
        switch self {
        case .five: "A light daily habit"
        case .ten: "Balanced and sustainable"
        case .fifteen: "Faster progress"
        }
    }

    var icon: String {
        switch self {
        case .five: "clock"
        case .ten: "clock.fill"
        case .fifteen: "timer"
        }
    }
}

struct UserProfile: Codable, Equatable {
    var primaryGoal: PrimaryGoal
    var chineseLevel: ChineseLevel
    var dailyMinutes: DailyMinutes
    var travelDate: Date?
    var hasTravelDate: Bool
    var onboardingCompleted: Bool

    static let `default` = UserProfile(
        primaryGoal: .learnChinese,
        chineseLevel: .completeBeginner,
        dailyMinutes: .ten,
        travelDate: nil,
        hasTravelDate: false,
        onboardingCompleted: false
    )

    var daysUntilTravel: Int? {
        guard hasTravelDate, let travelDate else { return nil }
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: Date())
        let end = calendar.startOfDay(for: travelDate)
        return calendar.dateComponents([.day], from: start, to: end).day
    }
}
