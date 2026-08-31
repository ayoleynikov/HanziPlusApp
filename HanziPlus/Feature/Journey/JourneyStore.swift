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

    func markVisited(_ city: JourneyCity) {
        guard completions[city.id] == nil else { return }
        markComplete(city, percent: 100, at: Date())
    }

    @discardableResult
    func sync(progress: JourneyProgress, achievementStore: AchievementStore) -> JourneyCity? {
        _ = progress
        let count = completions.count
        if count >= 2 { achievementStore.unlockJourneyProgress(citiesCompleted: count) }
        if count >= JourneyCityCatalog.all.count { achievementStore.unlockJourneyComplete() }
        return nil
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

    func resetAll() {
        completions.removeAll()
        celebrationCity = nil
        persist()
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
