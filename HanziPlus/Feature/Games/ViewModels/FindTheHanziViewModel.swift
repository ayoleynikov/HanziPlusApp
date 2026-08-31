//
//  FindTheHanziViewModel.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class FindTheHanziViewModel: GameSession {

    let studySet: StudySet
    let gameKind: GameKind = .findTheHanzi
    let difficulty: GameDifficulty

    private let wordPool: [Word]
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

    init(studySet: StudySet, difficulty: GameDifficulty = .medium) {
        self.studySet = studySet
        self.difficulty = difficulty
        self.wordPool = WordLoader.load(fileName: studySet.fileName)
        self.words = Array(wordPool.shuffled().prefix(difficulty.questionCount))
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

    var gridOptions: [String] { currentOptions }

    func select(_ hanzi: String) {
        guard let currentWord, selectedAnswer == nil else { return }

        selectedAnswer = hanzi
        showResult = true

        if hanzi == currentWord.hanzi {
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
        words = Array(wordPool.shuffled().prefix(difficulty.questionCount))
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
        currentOptions = MultipleChoiceHelper.hanziOptions(
            correct: currentWord.hanzi,
            pool: wordPool,
            excluding: currentWord.id,
            count: difficulty.gridDimension * difficulty.gridDimension,
            seed: optionSeed(for: currentWord)
        )
    }

    private func optionSeed(for word: Word) -> UInt64 {
        DailyLessonPlanner.stableSeed("\(studySet.fileName)|find|\(word.id)|\(difficulty.rawValue)")
    }
}
