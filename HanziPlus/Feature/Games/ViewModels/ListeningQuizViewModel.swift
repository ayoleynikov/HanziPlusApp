//
//  ListeningQuizViewModel.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class ListeningQuizViewModel: GameSession {

    let studySet: StudySet
    let gameKind: GameKind = .listeningQuiz
    let difficulty: GameDifficulty

    private let wordPool: [Word]
    private(set) var words: [Word]
    private(set) var currentIndex = 0
    private(set) var selectedAnswer: String?
    private(set) var showResult = false
    private(set) var correctCount = 0
    private(set) var wrongCount = 0
    private(set) var streak = 0
    private(set) var comboPeak = 0
    private(set) var isFinished = false
    private(set) var result: GameResult?
    private(set) var hasPlayedCurrentAudio = false

    private var startedAt = Date()

    init(studySet: StudySet, difficulty: GameDifficulty = .medium) {
        self.studySet = studySet
        self.difficulty = difficulty
        self.wordPool = GameWordProvider.words(for: studySet)
        self.words = Array(wordPool.shuffled().prefix(difficulty.questionCount))
    }

    var currentWord: Word? {
        guard words.indices.contains(currentIndex) else { return nil }
        return words[currentIndex]
    }

    var progress: Double {
        guard !words.isEmpty else { return 0 }
        return Double(currentIndex + 1) / Double(words.count)
    }

    var options: [String] {
        guard let currentWord else { return [] }
        return MultipleChoiceHelper.hanziOptions(
            correct: currentWord.hanzi,
            pool: wordPool,
            excluding: currentWord.id,
            count: difficulty.optionCount
        )
    }

    func markAudioPlayed() {
        hasPlayedCurrentAudio = true
    }

    func select(_ answer: String) {
        guard let currentWord, selectedAnswer == nil else { return }

        selectedAnswer = answer
        showResult = true

        if answer == currentWord.hanzi {
            correctCount += 1
            streak += 1
            comboPeak = max(comboPeak, streak)
        } else {
            wrongCount += 1
            streak = 0
        }
    }

    func nextQuestion() {
        if currentIndex < words.count - 1 {
            currentIndex += 1
            selectedAnswer = nil
            showResult = false
            hasPlayedCurrentAudio = false
        }
    }

    func finish(
        scoreStore: GameScoreStore,
        statisticsStore: StatisticsStore,
        achievementStore: AchievementStore,
        smartReviewStore: SmartReviewStore
    ) {
        if let word = currentWord, selectedAnswer != word.hanzi {
            smartReviewStore.recordWrong(word: word, studySet: studySet)
        }

        result = GameSessionRecorder.finish(
            gameKind: gameKind,
            studySetFileName: studySet.fileName,
            correct: correctCount,
            wrong: wrongCount,
            comboPeak: comboPeak,
            streak: streak,
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
        streak = 0
        comboPeak = 0
        isFinished = false
        result = nil
        hasPlayedCurrentAudio = false
    }
}
