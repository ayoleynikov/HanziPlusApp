//
//  UserProfileStore.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class UserProfileStore {

    private let defaults = UserDefaults.standard
    private let storageKey = "userProfile.v1"

    private(set) var profile: UserProfile

    init() {
        if let data = defaults.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode(UserProfile.self, from: data) {
            profile = decoded
        } else {
            profile = .default
        }
    }

    var needsOnboarding: Bool {
        !profile.onboardingCompleted
    }

    func update(_ transform: (inout UserProfile) -> Void) {
        transform(&profile)
        persist()
    }

    func completeOnboarding(
        goal: PrimaryGoal,
        level: ChineseLevel,
        minutes: DailyMinutes,
        travelDate: Date?,
        hasTravelDate: Bool
    ) {
        profile.primaryGoal = goal
        profile.chineseLevel = level
        profile.dailyMinutes = minutes
        profile.travelDate = hasTravelDate ? travelDate : nil
        profile.hasTravelDate = hasTravelDate
        profile.onboardingCompleted = true
        persist()
    }

    func saveEdits(
        goal: PrimaryGoal,
        level: ChineseLevel,
        minutes: DailyMinutes,
        travelDate: Date?,
        hasTravelDate: Bool
    ) {
        profile.primaryGoal = goal
        profile.chineseLevel = level
        profile.dailyMinutes = minutes
        profile.travelDate = hasTravelDate ? travelDate : nil
        profile.hasTravelDate = hasTravelDate
        // Keep onboardingCompleted true — editing does not reset progress.
        persist()
    }

    private func persist() {
        guard let data = try? JSONEncoder().encode(profile) else { return }
        defaults.set(data, forKey: storageKey)
    }
}
