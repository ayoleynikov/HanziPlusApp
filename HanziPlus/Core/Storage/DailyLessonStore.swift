//
//  DailyLessonStore.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class DailyLessonStore {

    private let defaults = UserDefaults.standard
    private let storageKey = "dailyLesson.session.v1"

    private(set) var session: DailyLessonSession?

    init() {
        load()
    }

    var status: DailyLessonStatus {
        guard let session, session.dateKey == DailyLessonPlanner.dateKey() else {
            return .notStarted
        }
        if session.completed { return .complete }
        if session.phase == .preview && session.currentIndex == 0 && session.answers.isEmpty {
            return .notStarted
        }
        return .inProgress
    }

    func ensureTodaySession(
        profile: UserProfile,
        learnedStore: LearnedWordsStore
    ) -> DailyLessonSession {
        let today = DailyLessonPlanner.dateKey()
        let fileName = DailyLessonPlanner.recommendedFileName(for: profile)
        let signature = DailyLessonPlanner.profileSignature(profile: profile, fileName: fileName)

        if var existing = session, existing.dateKey == today {
            if existing.completed {
                return existing
            }
            if existing.profileSignature != signature {
                let rebuilt = buildSession(profile: profile, learnedStore: learnedStore, dateKey: today)
                session = rebuilt
                persist()
                return rebuilt
            }
            return existing
        }

        let created = buildSession(profile: profile, learnedStore: learnedStore, dateKey: today)
        session = created
        persist()
        return created
    }

    func update(_ transform: (inout DailyLessonSession) -> Void) {
        guard var current = session else { return }
        transform(&current)
        session = current
        persist()
    }

    func replace(_ newSession: DailyLessonSession) {
        session = newSession
        persist()
    }

    private func buildSession(
        profile: UserProfile,
        learnedStore: LearnedWordsStore,
        dateKey: String
    ) -> DailyLessonSession {
        let fileName = DailyLessonPlanner.recommendedFileName(for: profile)
        let allWords = WordLoader.load(fileName: fileName)
        let learnedHanzi = Set(
            allWords
                .map(\.hanzi)
                .filter { learnedStore.isLearned(fileName: fileName, hanzi: $0) }
        )
        let target = DailyLessonPlanner.targetWordCount(for: profile)
        let selection = DailyLessonPlanner.selectWords(
            fileName: fileName,
            targetCount: target,
            learnedHanzi: learnedHanzi,
            dateKey: dateKey,
            allWords: allWords
        )

        return DailyLessonSession(
            dateKey: dateKey,
            lessonID: "\(dateKey)-\(fileName)",
            fileName: fileName,
            wordHanzi: selection.hanzi,
            isReviewLesson: selection.isReviewLesson,
            phase: .preview,
            currentIndex: 0,
            answers: [:],
            completed: false,
            completedAt: nil,
            profileSignature: DailyLessonPlanner.profileSignature(profile: profile, fileName: fileName)
        )
    }

    private func load() {
        guard let data = defaults.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode(DailyLessonSession.self, from: data)
        else { return }
        session = decoded
    }

    private func persist() {
        guard let session,
              let data = try? JSONEncoder().encode(session)
        else { return }
        defaults.set(data, forKey: storageKey)
    }
}
