//
//  MatchPairsViewModel.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class MatchPairsViewModel: GameSession {

    let studySet: StudySet
    let difficulty: GameDifficulty
    let gameKind: GameKind = .matchPairs

    private let wordPool: [Word]
    private let questionCount: Int
    private(set) var words: [Word]
    private(set) var currentIndex = 0
    private(set) var selectedAnswer: String?
    private(set) var showResult = false
    private(set) var correctCount = 0
    private(set) var wrongCount = 0
    private(set) var isFinished = false
    private(set) var result: GameResult?

    private var startedAt = Date()

    init(studySet: StudySet, difficulty: GameDifficulty = .medium, questionCount: Int? = nil) {
        self.studySet = studySet
        self.difficulty = difficulty
        let count = questionCount ?? difficulty.questionCount
        self.questionCount = count
        self.wordPool = GameWordProvider.words(for: studySet)
        self.words = Array(wordPool.shuffled().prefix(count))
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
        return MultipleChoiceHelper.englishOptions(
            correct: currentWord.localizedMeaning,
            pool: wordPool,
            excluding: currentWord.id,
            count: difficulty.optionCount
        )
    }

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
        }
    }

    func finish(scoreStore: GameScoreStore, statisticsStore: StatisticsStore) {
        let total = max(1, correctCount + wrongCount)
        let accuracy = Int(Double(correctCount) / Double(total) * 100)
        let score = correctCount * 100 + max(0, accuracy - 50)
        let elapsed = Int(Date().timeIntervalSince(startedAt))
        let xp = GameResult.xp(
            correct: correctCount,
            comboPeak: 1,
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
            elapsedSeconds: elapsed,
            xpEarned: xp,
            correctCount: correctCount,
            wrongCount: wrongCount,
            comboPeak: 1,
            isNewRecord: isNewRecord
        )
        isFinished = true
    }

    func restart() {
        startedAt = Date()
        words = Array(wordPool.shuffled().prefix(questionCount))
        currentIndex = 0
        selectedAnswer = nil
        showResult = false
        correctCount = 0
        wrongCount = 0
        isFinished = false
        result = nil
    }
}
