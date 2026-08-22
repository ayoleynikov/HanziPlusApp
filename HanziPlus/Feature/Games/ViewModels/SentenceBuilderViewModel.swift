//
//  SentenceBuilderViewModel.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class SentenceBuilderViewModel: GameSession {

    let studySet: StudySet
    let difficulty: GameDifficulty
    let gameKind: GameKind = .sentenceBuilder

    private(set) var puzzles: [SentencePuzzle]
    private(set) var currentIndex = 0
    private(set) var builtTokens: [String] = []
    private(set) var bankTokens: [String] = []
    private(set) var showResult = false
    private(set) var wasCorrect = false
    private(set) var correctCount = 0
    private(set) var wrongCount = 0
    private(set) var isFinished = false
    private(set) var result: GameResult?

    private var startedAt = Date()

    init(studySet: StudySet, difficulty: GameDifficulty = .medium, puzzleCount: Int? = nil) {
        self.studySet = studySet
        self.difficulty = difficulty
        let count = puzzleCount ?? difficulty.questionCount
        self.puzzles = SentencePuzzle.puzzles(from: studySet, limit: count)

        if puzzles.isEmpty {
            self.puzzles = []
        } else {
            resetPuzzleState()
        }
    }

    var hasPuzzles: Bool {
        !puzzles.isEmpty
    }

    var currentPuzzle: SentencePuzzle? {
        guard puzzles.indices.contains(currentIndex) else { return nil }
        return puzzles[currentIndex]
    }

    var progress: Double {
        guard !puzzles.isEmpty else { return 0 }
        return Double(currentIndex + 1) / Double(puzzles.count)
    }

    var isPuzzleComplete: Bool {
        guard let puzzle = currentPuzzle else { return false }
        return builtTokens.count == puzzle.tokens.count
    }

    func moveToBuilt(_ token: String) {
        guard !showResult, let index = bankTokens.firstIndex(of: token) else { return }
        bankTokens.remove(at: index)
        builtTokens.append(token)
    }

    func moveToBank(_ token: String) {
        guard !showResult, let index = builtTokens.firstIndex(of: token) else { return }
        builtTokens.remove(at: index)
        bankTokens.append(token)
    }

    func insertBuilt(_ token: String, at index: Int) {
        guard !showResult else { return }

        if let bankIndex = bankTokens.firstIndex(of: token) {
            bankTokens.remove(at: bankIndex)
            builtTokens.insert(token, at: min(index, builtTokens.count))
        } else if let builtIndex = builtTokens.firstIndex(of: token) {
            builtTokens.remove(at: builtIndex)
            builtTokens.insert(token, at: min(index, builtTokens.count))
        }
    }

    func checkAnswer() {
        guard let puzzle = currentPuzzle, isPuzzleComplete, !showResult else { return }

        wasCorrect = builtTokens == puzzle.correctOrder
        showResult = true

        if wasCorrect {
            correctCount += 1
        } else {
            wrongCount += 1
        }
    }

    func nextPuzzle() {
        if currentIndex < puzzles.count - 1 {
            currentIndex += 1
            showResult = false
            wasCorrect = false
            resetPuzzleState()
        }
    }

    func finish(scoreStore: GameScoreStore, statisticsStore: StatisticsStore) {
        let total = max(1, correctCount + wrongCount)
        let accuracy = Int(Double(correctCount) / Double(total) * 100)
        let score = correctCount * 120 + accuracy
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
        puzzles = SentencePuzzle.puzzles(from: studySet, limit: puzzles.count)
        currentIndex = 0
        correctCount = 0
        wrongCount = 0
        isFinished = false
        result = nil
        showResult = false
        wasCorrect = false
        resetPuzzleState()
    }

    private func resetPuzzleState() {
        guard let puzzle = currentPuzzle else {
            builtTokens = []
            bankTokens = []
            return
        }
        builtTokens = []
        bankTokens = puzzle.tokens.shuffled()
    }
}
