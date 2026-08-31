//
//  AppDailyProgress.swift
//  HanziPlus
//

import Foundation

enum AppDailyProgress {

    static func weakWordsCount(
        profile: UserProfile,
        smartReview: SmartReviewStore,
        learnedStore: LearnedWordsStore
    ) -> Int {
        let fileName = DailyLessonPlanner.recommendedFileName(for: profile)
        guard let set = SampleStudySets.studySet(fileName: fileName) else { return 0 }
        return smartReview.dueCount(for: set, learnedStore: learnedStore)
    }

    static func reviewSetFileName(for profile: UserProfile, lessonFileName: String?) -> String {
        if profile.primaryGoal == .travelToChina {
            return SampleStudySets.travel.fileName
        }
        return lessonFileName ?? DailyLessonPlanner.recommendedFileName(for: profile)
    }
}
