//
//  TypingChallengeViewModel.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class TypingChallengeViewModel: GameSession {

    let studySet: StudySet
    let gameKind: GameKind = .typingChallenge
    let difficulty: GameDifficulty

    private let wordPool: [Word]
    private(set) var words: [Word]
    private(set) var currentIndex = 0
    var input = ""
    private(set) var showResult = false
    private(set) var wasCorrect = false
    private(set) var correctCount = 0
    private(set) var wrongCount = 0
    private(set) var streak = 0
    private(set) var comboPeak = 0
    private(set) var isFinished = false
    private(set) var result: GameResult?

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

    func submit() {
        guard let currentWord, !showResult else { return }

        let normalizedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        wasCorrect = normalizedInput == currentWord.hanzi
        showResult = true

        if wasCorrect {
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
            input = ""
            showResult = false
            wasCorrect = false
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
        input = ""
        showResult = false
        wasCorrect = false
        correctCount = 0
        wrongCount = 0
        streak = 0
        comboPeak = 0
        isFinished = false
        result = nil
    }
}
