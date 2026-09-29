//
//  DailyLessonStore.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class DailyLessonStore {

    private let defaults = UserDefaults.standard
    private let storageKey = "dailyLesson.session.v2"

    private(set) var session: DailyLessonSession?

    /// Read-only access for SwiftUI rendering. Session creation belongs in a
    /// lifecycle task, never in a body-computed property.
    var todaySession: DailyLessonSession? {
        guard let session, session.dateKey == DailyLessonPlanner.dateKey() else { return nil }
        return session
    }

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

    @discardableResult
    func ensureTodaySession(
        profile: UserProfile,
        learnedStore: LearnedWordsStore
    ) -> DailyLessonSession {
        let today = DailyLessonPlanner.dateKey()
        let fileName = DailyLessonPlanner.recommendedFileName(for: profile)
        let signature = DailyLessonPlanner.profileSignature(profile: profile, fileName: fileName)

        if let existing = session, existing.dateKey == today {
            if existing.completed {
                return normalizeLegacySession(existing)
            }
            if existing.profileSignature != signature {
                let rebuilt = buildSession(profile: profile, learnedStore: learnedStore, dateKey: today)
                session = rebuilt
                persist()
                return rebuilt
            }
            return normalizeLegacySession(existing)
        }

        let created = buildSession(profile: profile, learnedStore: learnedStore, dateKey: today)
        let normalized = normalizeLegacySession(created)
        session = normalized
        persist()
        return normalized
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

    func resetProgress() {
        session = nil
        defaults.removeObject(forKey: storageKey)
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
        session = normalizeLegacySession(decoded)
    }

    private func normalizeLegacySession(_ session: DailyLessonSession) -> DailyLessonSession {
        var normalized = session
        if normalized.phase == .summary && !normalized.completed {
            normalized.completed = true
            normalized.completedAt = normalized.completedAt ?? Date()
        }
        return normalized
    }

    private func persist() {
        guard let session,
              let data = try? JSONEncoder().encode(session)
        else { return }
        defaults.set(data, forKey: storageKey)
    }
}
