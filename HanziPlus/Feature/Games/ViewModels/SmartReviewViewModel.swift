//
//  SmartReviewViewModel.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class SmartReviewViewModel: GameSession {

    let studySet: StudySet
    let gameKind: GameKind = .smartReview

    private let vocabularyPool: [Word]
    private(set) var words: [Word]
    private(set) var currentOptions: [String] = []
    private(set) var currentIndex = 0
    private(set) var selectedAnswer: String?
    private(set) var showResult = false
    private(set) var correctCount = 0
    private(set) var wrongCount = 0
    private(set) var isFinished = false
    private(set) var result: GameResult?

    private var startedAt = Date()

    let dueCount: Int
    let estimatedMinutes: Int

    init(studySet: StudySet, learnedStore: LearnedWordsStore, smartReviewStore: SmartReviewStore) {
        self.studySet = studySet
        self.vocabularyPool = WordLoader.load(fileName: studySet.fileName)
        let reviewWords = smartReviewStore.reviewWords(for: studySet, learnedStore: learnedStore)
        let sessionWords = Array(reviewWords.prefix(min(15, reviewWords.count)))
        self.words = sessionWords
        self.dueCount = reviewWords.count
        self.estimatedMinutes = smartReviewStore.estimatedMinutes(for: sessionWords.count)
        loadCurrentOptions()
    }

    var currentWord: Word? {
        guard words.indices.contains(currentIndex) else { return nil }
        return words[currentIndex]
    }

    var progress: Double {
        guard !words.isEmpty else { return 0 }
        return Double(currentIndex + 1) / Double(words.count)
    }

    var completionPercent: Int {
        guard dueCount > 0 else { return 100 }
        return Int(Double(currentIndex + 1) / Double(words.count) * 100)
    }

    var options: [String] { currentOptions }

    func select(_ answer: String) {
        guard let currentWord, selectedAnswer == nil else { return }

        selectedAnswer = answer
        showResult = true

        if answer == currentWord.localizedMeaning {
            correctCount += 1
        } else {
            wrongCount += 1
        }
    }

    func nextQuestion() {
        if currentIndex < words.count - 1 {
            currentIndex += 1
            selectedAnswer = nil
            showResult = false
            loadCurrentOptions()
        }
    }

    func finish(
        scoreStore: GameScoreStore,
        statisticsStore: StatisticsStore,
        achievementStore: AchievementStore,
        smartReviewStore: SmartReviewStore
    ) {
        result = GameSessionRecorder.finish(
            gameKind: gameKind,
            studySetFileName: studySet.fileName,
            correct: correctCount,
            wrong: wrongCount,
            comboPeak: 1,
            streak: 0,
            elapsedSeconds: Int(Date().timeIntervalSince(startedAt)),
            scoreStore: scoreStore,
            statisticsStore: statisticsStore,
            achievementStore: achievementStore,
            smartReviewStore: smartReviewStore
        )
        isFinished = true
    }

    func restart() {
        startedAt = Date()
        currentIndex = 0
        selectedAnswer = nil
        showResult = false
        correctCount = 0
        wrongCount = 0
        isFinished = false
        result = nil
        loadCurrentOptions()
    }

    private func loadCurrentOptions() {
        guard let currentWord else {
            currentOptions = []
            return
        }
        currentOptions = MultipleChoiceHelper.englishOptions(
            correct: currentWord.localizedMeaning,
            pool: vocabularyPool,
            excluding: currentWord.id,
            seed: optionSeed(for: currentWord)
        )
    }

    private func optionSeed(for word: Word) -> UInt64 {
        DailyLessonPlanner.stableSeed("\(studySet.fileName)|review|\(word.id)")
    }
}
