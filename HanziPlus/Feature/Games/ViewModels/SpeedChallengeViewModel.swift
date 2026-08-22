//
//  SpeedChallengeViewModel.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class SpeedChallengeViewModel: GameSession {

    let studySet: StudySet
    let gameKind: GameKind = .speedChallenge
    let durationSeconds = 60

    private let wordPool: [Word]
    private var startedAt = Date()
    private var timerStart = Date()

    private(set) var words: [Word] = []
    private(set) var currentIndex = 0
    private(set) var selectedAnswer: String?
    private(set) var showResult = false
    private(set) var correctCount = 0
    private(set) var wrongCount = 0
    private(set) var combo = 0
    private(set) var comboPeak = 0
    private(set) var remainingSeconds = 60
    private(set) var isFinished = false
    private(set) var result: GameResult?
    private(set) var isTimerRunning = false

    init(studySet: StudySet) {
        self.studySet = studySet
        self.wordPool = GameWordProvider.words(for: studySet)
        self.remainingSeconds = durationSeconds
        loadNextBatch()
    }

    var currentWord: Word? {
        guard words.indices.contains(currentIndex) else { return nil }
        return words[currentIndex]
    }

    var timerProgress: Double {
        Double(remainingSeconds) / Double(durationSeconds)
    }

    var options: [String] {
        guard let currentWord else { return [] }
        return MultipleChoiceHelper.options(
            correct: currentWord.localizedMeaning,
            pool: wordPool,
            excluding: currentWord.id
        )
    }

    func startTimer() {
        guard !isTimerRunning else { return }
        isTimerRunning = true
        timerStart = Date()
        startedAt = Date()
    }

    func tick() {
        guard isTimerRunning, !isFinished else { return }

        let elapsed = Int(Date().timeIntervalSince(timerStart))
        remainingSeconds = max(0, durationSeconds - elapsed)

        if remainingSeconds == 0 {
            isTimerRunning = false
        }
    }

    func select(_ answer: String) {
        guard let currentWord, selectedAnswer == nil, isTimerRunning, remainingSeconds > 0 else { return }

        selectedAnswer = answer
        showResult = true

        if answer == currentWord.localizedMeaning {
            correctCount += 1
            combo += 1
            comboPeak = max(comboPeak, combo)
        } else {
            wrongCount += 1
            combo = 0
        }
    }

    func nextQuestion() {
        guard remainingSeconds > 0 else { return }

        if currentIndex < words.count - 1 {
            currentIndex += 1
        } else {
            loadNextBatch()
            currentIndex = 0
        }

        selectedAnswer = nil
        showResult = false
    }

    func finish(scoreStore: GameScoreStore, statisticsStore: StatisticsStore) {
        guard !isFinished else { return }

        isTimerRunning = false
        let total = max(1, correctCount + wrongCount)
        let accuracy = Int(Double(correctCount) / Double(total) * 100)
        let score = correctCount * 50 + comboPeak * 25 + accuracy
        let elapsed = durationSeconds - remainingSeconds
        let xp = GameResult.xp(
            correct: correctCount,
            comboPeak: comboPeak,
            accuracy: accuracy,
            gameKind: gameKind
        )
        let isNewRecord = scoreStore.record(score: score, for: gameKind)
        scoreStore.addXP(xp, for: gameKind)
        statisticsStore.addQuiz(correct: correctCount, wrong: wrongCount)

        result = GameResult(
            gameKind: gameKind,
            studySetFileName: studySet.fileName,
            score: score,
            accuracy: accuracy,
            elapsedSeconds: max(elapsed, 1),
            xpEarned: xp,
            correctCount: correctCount,
            wrongCount: wrongCount,
            comboPeak: comboPeak,
            isNewRecord: isNewRecord
        )
        isFinished = true
    }

    func restart() {
        startedAt = Date()
        timerStart = Date()
        remainingSeconds = durationSeconds
        currentIndex = 0
        selectedAnswer = nil
        showResult = false
        correctCount = 0
        wrongCount = 0
        combo = 0
        comboPeak = 0
        isFinished = false
        result = nil
        isTimerRunning = false
        loadNextBatch()
    }

    private func loadNextBatch() {
        words = wordPool.shuffled()
    }
}
