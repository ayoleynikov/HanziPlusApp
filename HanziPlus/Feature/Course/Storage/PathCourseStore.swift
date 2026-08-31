//
//  PathCourseStore.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class PathCourseStore {

    private let defaults = UserDefaults.standard
    private let storageKey = "pathCourse.progress.v2"

    private(set) var progress: PathCourseProgress = .empty
    private(set) var course: PathCourse?

    init() {
        course = PathCourseLoader.loadCourse()
        load()
        if ProcessInfo.processInfo.arguments.contains("-ui-testing") {
            resetProgress()
        }
    }

    var courseCompletionPercent: Double {
        guard let course, course.totalLessons > 0 else { return 0 }
        return Double(completedLessonCount) / Double(course.totalLessons)
    }

    var completedLessonCount: Int {
        progress.lessonProgress.values.filter(\.isCompleted).count
    }

    var currentLessonSummary: PathLessonSummary? {
        guard let course else { return nil }
        if let currentID = progress.currentLessonID,
           let current = course.lessons.first(where: { $0.id == currentID }) {
            return current
        }
        return course.lessons.first(where: \.isAvailable)
    }

    var currentLessonNumber: Int {
        currentLessonSummary?.number ?? 1
    }

    var hasStartedCourse: Bool {
        !progress.lessonProgress.isEmpty
    }

    func status(for lesson: PathLessonSummary) -> PathLessonStatus {
        guard let lessonProgress = progress.lessonProgress[lesson.id] else {
            return .notStarted
        }
        if lessonProgress.isCompleted { return .completed }
        return .inProgress
    }

    func lessonProgress(for lessonID: String) -> PathLessonProgress {
        progress.lessonProgress[lessonID] ?? .fresh(lessonID: lessonID)
    }

    func isLessonUnlocked(_ lesson: PathLessonSummary) -> Bool {
        guard lesson.isAvailable else { return false }
        guard let course else { return false }
        guard let index = course.lessons.firstIndex(where: { $0.id == lesson.id }) else { return false }
        if index == 0 { return true }

        let priorLessons = course.lessons.prefix(index).filter(\.isAvailable)
        return priorLessons.allSatisfy { status(for: $0) == .completed }
    }

    func startLesson(_ lessonID: String) {
        var copy = progress
        copy.currentLessonID = lessonID
        if copy.lessonProgress[lessonID] == nil {
            copy.lessonProgress[lessonID] = .fresh(lessonID: lessonID)
        }
        progress = copy
        persist()
    }

    func updateLesson(_ lessonID: String, transform: (inout PathLessonProgress) -> Void) {
        var copy = progress
        var lessonProgress = copy.lessonProgress[lessonID] ?? .fresh(lessonID: lessonID)
        transform(&lessonProgress)
        copy.lessonProgress[lessonID] = lessonProgress
        copy.currentLessonID = lessonID
        progress = copy
        persist()
    }

    func completeLesson(_ lessonID: String) {
        updateLesson(lessonID) { lessonProgress in
            lessonProgress.isCompleted = true
            lessonProgress.completedAt = Date()
        }
    }

    func restartLesson(_ lessonID: String, keepCompleted: Bool = true) {
        let previous = progress.lessonProgress[lessonID]
        var copy = progress
        var fresh = PathLessonProgress.fresh(lessonID: lessonID)

        if keepCompleted, previous?.isCompleted == true {
            fresh.isCompleted = true
            fresh.completedAt = previous?.completedAt
        }

        copy.lessonProgress[lessonID] = fresh
        copy.currentLessonID = lessonID
        progress = copy
        persist()
    }

    func resetForPreviews() {
        resetProgress()
    }

    func resetProgress() {
        progress = .empty
        persist()
    }

    private func load() {
        guard let data = defaults.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode(PathCourseProgress.self, from: data)
        else { return }
        progress = decoded
    }

    private func persist() {
        guard let data = try? JSONEncoder().encode(progress) else { return }
        defaults.set(data, forKey: storageKey)
    }
}
