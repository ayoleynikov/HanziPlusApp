//
//  GameSessionRecorder.swift
//  HanziPlus
//

import Foundation

enum GameSessionRecorder {

    @MainActor
    static func finish(
        gameKind: GameKind,
        studySetFileName: String,
        correct: Int,
        wrong: Int,
        comboPeak: Int,
        streak: Int,
        elapsedSeconds: Int,
        scoreStore: GameScoreStore,
        statisticsStore: StatisticsStore,
        achievementStore: AchievementStore,
        smartReviewStore: SmartReviewStore? = nil,
        learnedStore: LearnedWordsStore? = nil
    ) -> GameResult {
        let total = max(1, correct + wrong)
        let accuracy = Int(Double(correct) / Double(total) * 100)
        let score = GameResult.score(
            correct: correct,
            accuracy: accuracy,
            comboPeak: comboPeak,
            gameKind: gameKind
        )
        let xp = GameResult.xp(
            correct: correct,
            comboPeak: comboPeak,
            accuracy: accuracy,
            streak: streak,
            gameKind: gameKind
        )

        let result = GameResult(
            gameKind: gameKind,
            studySetFileName: studySetFileName,
            score: score,
            accuracy: accuracy,
            elapsedSeconds: max(elapsedSeconds, 1),
            xpEarned: xp,
            correctCount: correct,
            wrongCount: wrong,
            comboPeak: comboPeak,
            isNewRecord: false
        )

        let isNewRecord = scoreStore.record(result: result, streak: streak)
        statisticsStore.addQuiz(correct: correct, wrong: wrong)

        achievementStore.evaluate(
            result: GameResult(
                gameKind: gameKind,
                studySetFileName: studySetFileName,
                score: score,
                accuracy: accuracy,
                elapsedSeconds: elapsedSeconds,
                xpEarned: xp,
                correctCount: correct,
                wrongCount: wrong,
                comboPeak: comboPeak,
                isNewRecord: isNewRecord
            ),
            totalXP: scoreStore.totalXPAllGames(),
            learnedCount: learnedStore.map { store in
                SampleStudySets.all.reduce(0) { $0 + store.learnedCount(for: $1.fileName) }
            } ?? 0,
            smartReviewStore: smartReviewStore
        )

        return GameResult(
            gameKind: gameKind,
            studySetFileName: studySetFileName,
            score: score,
            accuracy: accuracy,
            elapsedSeconds: max(elapsedSeconds, 1),
            xpEarned: xp,
            correctCount: correct,
            wrongCount: wrong,
            comboPeak: comboPeak,
            isNewRecord: isNewRecord
        )
    }
}
