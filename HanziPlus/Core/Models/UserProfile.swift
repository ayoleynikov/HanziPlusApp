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
        case .learnChinese: String(localized: "profile.goal.learn_chinese")
        case .travelToChina: String(localized: "profile.goal.travel_to_china")
        case .both: String(localized: "profile.goal.both")
        }
    }

    var subtitle: String {
        switch self {
        case .learnChinese: String(localized: "profile.goal.learn_chinese.subtitle")
        case .travelToChina: String(localized: "profile.goal.travel_to_china.subtitle")
        case .both: String(localized: "profile.goal.both.subtitle")
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
        case .completeBeginner: String(localized: "profile.level.complete_beginner")
        case .beginner: String(localized: "profile.level.beginner")
        case .intermediate: String(localized: "profile.level.intermediate")
        }
    }

    var subtitle: String {
        switch self {
        case .completeBeginner: String(localized: "profile.level.complete_beginner.subtitle")
        case .beginner: String(localized: "profile.level.beginner.subtitle")
        case .intermediate: String(localized: "profile.level.intermediate.subtitle")
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

    var title: String { L10n.minutes(rawValue) }

    var lessonWordCount: Int {
        switch self {
        case .five: 5
        case .ten: 8
        case .fifteen: 12
        }
    }

    var subtitle: String {
        switch self {
        case .five: String(localized: "profile.minutes.five.subtitle")
        case .ten: String(localized: "profile.minutes.ten.subtitle")
        case .fifteen: String(localized: "profile.minutes.fifteen.subtitle")
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
