//
//  AppProgressReset.swift
//  HanziPlus
//

import Foundation

enum AppProgressReset {

    static func resetEverything(
        learnedStore: LearnedWordsStore,
        sessionStore: StudySessionStore,
        smartReviewStore: SmartReviewStore,
        statisticsStore: StatisticsStore,
        pathStore: PathCourseStore,
        journeyStore: JourneyStore,
        scoreStore: GameScoreStore,
        dailyProgressStore: GamesDailyProgressStore,
        dailyChallengeStore: DailyChallengeStore,
        lessonStore: DailyLessonStore,
        phraseStore: TravelPhraseStore,
        achievementStore: AchievementStore,
        playHistoryStore: GamesPlayHistoryStore,
        favoritesStore: FavoritesStore
    ) {
        learnedStore.resetAll()
        sessionStore.resetAll()
        smartReviewStore.resetAll()
        statisticsStore.reset()
        pathStore.resetProgress()
        journeyStore.resetAll()
        scoreStore.resetAll()
        dailyProgressStore.resetAll()
        dailyChallengeStore.resetAll()
        lessonStore.resetProgress()
        phraseStore.resetAll()
        achievementStore.resetAll()
        playHistoryStore.resetAll()
        favoritesStore.resetAll()
    }
}
