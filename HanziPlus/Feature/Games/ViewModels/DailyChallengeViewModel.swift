//
//  DailyChallengeViewModel.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class DailyChallengeViewModel {

    let studySet: StudySet
    private(set) var currentTaskIndex = 0
    private(set) var taskCorrect = 0
    private(set) var taskWrong = 0
    private(set) var isTaskFinished = false
    private(set) var isAllFinished = false
    private(set) var result: GameResult?

    private var startedAt = Date()

    var tasks: [DailyChallengeTask] { dailyStore.state.tasks }
    var completedIDs: Set<String> { dailyStore.state.completedTaskIDs }

    private let dailyStore: DailyChallengeStore

    init(studySet: StudySet, dailyStore: DailyChallengeStore) {
        self.studySet = studySet
        self.dailyStore = dailyStore
        dailyStore.refreshIfNeeded()
    }

    var currentTask: DailyChallengeTask? {
        guard tasks.indices.contains(currentTaskIndex) else { return nil }
        return tasks[currentTaskIndex]
    }

    var overallProgress: Double {
        guard !tasks.isEmpty else { return 0 }
        return Double(completedIDs.count) / Double(tasks.count)
    }

    func recordTaskProgress(correct: Int, wrong: Int) {
        taskCorrect = correct
        taskWrong = wrong
        isTaskFinished = true
    }

    func completeCurrentTask() {
        guard let task = currentTask else { return }
        dailyStore.completeTask(task.id, xp: 25)
        isTaskFinished = false
        taskCorrect = 0
        taskWrong = 0

        if currentTaskIndex < tasks.count - 1 {
            currentTaskIndex += 1
        } else {
            isAllFinished = true
        }
    }

    func finish(
        scoreStore: GameScoreStore,
        statisticsStore: StatisticsStore,
        achievementStore: AchievementStore
    ) {
        let totalCorrect = tasks.count * 5
        let xp = 150 + dailyStore.state.completedTaskIDs.count * 25

        result = GameSessionRecorder.finish(
            gameKind: .dailyChallenge,
            studySetFileName: studySet.fileName,
            correct: totalCorrect,
            wrong: 0,
            comboPeak: 1,
            streak: dailyStore.streakDays,
            elapsedSeconds: Int(Date().timeIntervalSince(startedAt)),
            scoreStore: scoreStore,
            statisticsStore: statisticsStore,
            achievementStore: achievementStore
        )

        if var finalResult = result {
            finalResult = GameResult(
                gameKind: finalResult.gameKind,
                studySetFileName: finalResult.studySetFileName,
                score: finalResult.score + 100,
                accuracy: 100,
                elapsedSeconds: finalResult.elapsedSeconds,
                xpEarned: xp,
                correctCount: finalResult.correctCount,
                wrongCount: finalResult.wrongCount,
                comboPeak: finalResult.comboPeak,
                isNewRecord: finalResult.isNewRecord
            )
            result = finalResult
        }
    }
}
