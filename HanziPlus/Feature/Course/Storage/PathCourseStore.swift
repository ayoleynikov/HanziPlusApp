//
//  PathCourseStore.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class PathCourseStore {

    private let defaults = UserDefaults.standard
    private let storageKey = "pathCourse.progress.v3"

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

    func lessonChapterProgressFraction(lessonID: String, contentFile: String?) -> Double {
        guard let contentFile,
              let lesson = PathCourseLoader.loadLesson(fileName: contentFile),
              !lesson.chapters.isEmpty else { return 0 }
        let completed = lesson.chapters.filter {
            lessonProgress(for: lessonID).chapterProgress[$0.id]?.isCompleted == true
        }.count
        return Double(completed) / Double(lesson.chapters.count)
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

    func chapterStatus(for lesson: PathLesson, chapter: PathLessonChapter) -> PathChapterStatus {
        let lessonProgress = lessonProgress(for: lesson.id)
        if let chapterProgress = lessonProgress.chapterProgress[chapter.id], chapterProgress.isCompleted {
            return .completed
        }
        if lessonProgress.currentChapterID == chapter.id || lessonProgress.chapterProgress[chapter.id] != nil {
            return .inProgress
        }
        if isChapterUnlocked(lesson: lesson, chapter: chapter) {
            return .available
        }
        return .locked
    }

    func isChapterUnlocked(lesson: PathLesson, chapter: PathLessonChapter) -> Bool {
        if ProcessInfo.processInfo.arguments.contains("-ui-testing") {
            return isLessonUnlocked(lessonSummary(for: lesson))
        }
        guard isLessonUnlocked(lessonSummary(for: lesson)) else { return false }
        if chapter.number == 1 { return true }
        let prior = lesson.chapters.filter { $0.number < chapter.number }
        let progress = lessonProgress(for: lesson.id)
        return prior.allSatisfy { progress.chapterProgress[$0.id]?.isCompleted == true }
    }

    func chapterProgress(for lessonID: String, chapterID: String) -> PathChapterProgress {
        lessonProgress(for: lessonID).chapterProgress[chapterID] ?? .fresh(chapterID: chapterID)
    }

    func startChapter(lessonID: String, chapterID: String) {
        updateLesson(lessonID) { lessonProgress in
            lessonProgress.currentChapterID = chapterID
            if lessonProgress.chapterProgress[chapterID] == nil {
                lessonProgress.chapterProgress[chapterID] = .fresh(chapterID: chapterID)
            }
        }
    }

    func updateChapter(_ lessonID: String, chapterID: String, transform: (inout PathChapterProgress) -> Void) {
        updateLesson(lessonID) { lessonProgress in
            var chapterProgress = lessonProgress.chapterProgress[chapterID] ?? .fresh(chapterID: chapterID)
            transform(&chapterProgress)
            lessonProgress.chapterProgress[chapterID] = chapterProgress
            lessonProgress.currentChapterID = chapterID
        }
    }

    func completeChapter(lessonID: String, chapterID: String, lesson: PathLesson) {
        updateChapter(lessonID, chapterID: chapterID) { chapterProgress in
            chapterProgress.isCompleted = true
            chapterProgress.completedAt = Date()
        }

        let allComplete = lesson.chapters.allSatisfy {
            chapterProgress(for: lessonID, chapterID: $0.id).isCompleted
        }
        if allComplete {
            completeLesson(lessonID)
        }
    }

    func currentChapter(for lesson: PathLesson) -> PathLessonChapter? {
        let progress = lessonProgress(for: lesson.id)
        if let chapterID = progress.currentChapterID,
           let chapter = lesson.chapter(withID: chapterID) {
            return chapter
        }
        return lesson.chapters.first(where: { isChapterUnlocked(lesson: lesson, chapter: $0) && chapterStatus(for: lesson, chapter: $0) != .completed })
            ?? lesson.chapters.first
    }

    private func lessonSummary(for lesson: PathLesson) -> PathLessonSummary {
        course?.lessons.first(where: { $0.id == lesson.id })
            ?? PathLessonSummary(
                id: lesson.id,
                number: lesson.number,
                sourceLessonNumbers: lesson.sourceLessonNumbers,
                chineseTitle: lesson.chineseTitle,
                pinyinTitle: lesson.pinyinTitle,
                translationTitle: lesson.translationTitle,
                vocabularyCount: lesson.countedVocabularyTotal,
                contentFile: lesson.id,
                isAvailable: true
            )
    }

    func resetForPreviews() {
        resetProgress()
    }

    func resetProgress() {
        progress = .empty
        persist()
    }

    private func load() {
        if let data = defaults.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode(PathCourseProgress.self, from: data) {
            progress = PathCourseProgressMigration.finalizeProgress(decoded, course: course)
            if progress != decoded {
                persist()
            }
            return
        }

        let legacyKey = "pathCourse.progress.v2"
        if let data = defaults.data(forKey: legacyKey),
           let decoded = try? JSONDecoder().decode(PathCourseProgress.self, from: data) {
            progress = PathCourseProgressMigration.finalizeProgress(decoded, course: course)
            persist()
        }
    }

    private func persist() {
        guard let data = try? JSONEncoder().encode(progress) else { return }
        defaults.set(data, forKey: storageKey)
    }
}
