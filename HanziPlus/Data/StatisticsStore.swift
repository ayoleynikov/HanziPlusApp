//
//  StatisticsStore.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import Foundation
import Observation

@Observable
final class StatisticsStore {

    private let defaults = UserDefaults.standard

    private enum Keys {
        static let quizzesCompleted = "statistics.quizzesCompleted"
        static let correctAnswers = "statistics.correctAnswers"
        static let wrongAnswers = "statistics.wrongAnswers"
        static let bestAccuracy = "statistics.bestAccuracy"
    }

    private(set) var quizzesCompleted = 0
    private(set) var correctAnswers = 0
    private(set) var wrongAnswers = 0
    private(set) var bestAccuracy = 0

    var totalAnswers: Int {
        correctAnswers + wrongAnswers
    }

    var accuracy: Int {
        guard totalAnswers > 0 else { return 0 }

        return Int(Double(correctAnswers) / Double(totalAnswers) * 100)
    }

    init() {
        load()
    }

    func addQuiz(correct: Int, wrong: Int) {
        quizzesCompleted += 1
        correctAnswers += correct
        wrongAnswers += wrong

        let quizAccuracy = Int(
            Double(correct) / Double(max(1, correct + wrong)) * 100
        )

        if quizAccuracy > bestAccuracy {
            bestAccuracy = quizAccuracy
        }

        persist()
    }

    func reset() {
        quizzesCompleted = 0
        correctAnswers = 0
        wrongAnswers = 0
        bestAccuracy = 0

        defaults.removeObject(forKey: Keys.quizzesCompleted)
        defaults.removeObject(forKey: Keys.correctAnswers)
        defaults.removeObject(forKey: Keys.wrongAnswers)
        defaults.removeObject(forKey: Keys.bestAccuracy)
    }

    private func load() {
        quizzesCompleted = defaults.integer(forKey: Keys.quizzesCompleted)
        correctAnswers = defaults.integer(forKey: Keys.correctAnswers)
        wrongAnswers = defaults.integer(forKey: Keys.wrongAnswers)
        bestAccuracy = defaults.integer(forKey: Keys.bestAccuracy)
    }

    private func persist() {
        defaults.set(quizzesCompleted, forKey: Keys.quizzesCompleted)
        defaults.set(correctAnswers, forKey: Keys.correctAnswers)
        defaults.set(wrongAnswers, forKey: Keys.wrongAnswers)
        defaults.set(bestAccuracy, forKey: Keys.bestAccuracy)
    }
}
