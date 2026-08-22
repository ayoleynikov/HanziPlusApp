//
//  JourneyStore.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class JourneyStore {

    private let defaults = UserDefaults.standard
    private let completionsKey = "journey.cityCompletions"

    private(set) var completions: [String: CityCompletionRecord] = [:]
    var celebrationCity: JourneyCity?

    init() {
        load()
    }

    func completion(for cityID: String) -> CityCompletionRecord? {
        completions[cityID]
    }

    func isCompleted(_ city: JourneyCity) -> Bool {
        completions[city.id] != nil
    }

    /// Whether the user may open the city detail screen.
    func isUnlocked(_ city: JourneyCity, progress: JourneyProgress) -> Bool {
        guard let index = JourneyCityCatalog.all.firstIndex(where: { $0.id == city.id }) else { return false }
        if index == 0 { return true }

        for prior in JourneyCityCatalog.all.prefix(index) {
            if completions[prior.id] == nil { return false }
        }

        return city.requirements.isMet(by: progress, dailyStreak: progress.dailyStreak)
            || isCompleted(city)
    }

    func progressFraction(for city: JourneyCity, progress: JourneyProgress) -> Double {
        if isCompleted(city) { return 1 }
        return city.requirements.completionFraction(for: progress, dailyStreak: progress.dailyStreak)
    }

    @discardableResult
    func sync(progress: JourneyProgress, achievementStore: AchievementStore) -> JourneyCity? {
        var newlyUnlocked: JourneyCity?

        if completions[JourneyCityCatalog.all[0].id] == nil {
            markComplete(JourneyCityCatalog.all[0], percent: 100, at: Date())
        }

        for city in JourneyCityCatalog.all {
            guard completions[city.id] == nil else { continue }
            guard allPriorCompleted(city) else { continue }
            guard city.requirements.isMet(by: progress, dailyStreak: progress.dailyStreak) else { continue }

            markComplete(city, percent: 100, at: Date())
            newlyUnlocked = city
        }

        let count = completions.count
        if count >= 2 { achievementStore.unlockJourneyProgress(citiesCompleted: count) }
        if count >= JourneyCityCatalog.all.count { achievementStore.unlockJourneyComplete() }

        if let newlyUnlocked {
            celebrationCity = newlyUnlocked
        }

        return newlyUnlocked
    }

    func dismissCelebration() {
        celebrationCity = nil
    }

    var collectedSouvenirs: [(city: JourneyCity, record: CityCompletionRecord)] {
        JourneyCityCatalog.all.compactMap { city in
            guard let record = completions[city.id] else { return nil }
            return (city, record)
        }
    }

    private func allPriorCompleted(_ city: JourneyCity) -> Bool {
        guard let index = JourneyCityCatalog.all.firstIndex(where: { $0.id == city.id }) else { return false }
        for prior in JourneyCityCatalog.all.prefix(index) {
            if completions[prior.id] == nil { return false }
        }
        return true
    }

    private func markComplete(_ city: JourneyCity, percent: Int, at date: Date) {
        completions[city.id] = CityCompletionRecord(
            cityID: city.id,
            completedAt: date,
            completionPercent: percent
        )
        persist()
    }

    private func load() {
        guard let data = defaults.data(forKey: completionsKey),
              let decoded = try? JSONDecoder().decode([String: CityCompletionRecord].self, from: data)
        else { return }
        completions = decoded
    }

    private func persist() {
        guard let data = try? JSONEncoder().encode(completions) else { return }
        defaults.set(data, forKey: completionsKey)
    }
}
