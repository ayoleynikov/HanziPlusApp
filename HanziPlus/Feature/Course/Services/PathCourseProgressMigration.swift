//
//  PathCourseProgressMigration.swift
//  HanziPlus
//

import Foundation

enum PathCourseProgressMigration {

    static func migrateLessonProgress(
        _ progress: [String: PathLessonProgress],
        schemaVersion: Int
    ) -> [String: PathLessonProgress] {
        guard schemaVersion < PathCourseProgress.currentSchemaVersion else {
            return progress
        }
        return progress
    }

    static func finalizeProgress(
        _ progress: PathCourseProgress,
        course: PathCourse?
    ) -> PathCourseProgress {
        guard let course else { return progress }

        var copy = progress
        var didMigrate = false

        for lessonSummary in course.lessons {
            guard var lessonProgress = copy.lessonProgress[lessonSummary.id] else { continue }
            guard needsChapterMigration(lessonProgress) else { continue }
            guard let contentFile = lessonSummary.contentFile,
                  let lesson = PathCourseLoader.loadLesson(fileName: contentFile) else { continue }

            lessonProgress = migrateLessonProgressToChapters(lessonProgress, lesson: lesson)
            copy.lessonProgress[lessonSummary.id] = lessonProgress
            didMigrate = true
        }

        if didMigrate {
            copy.schemaVersion = PathCourseProgress.currentSchemaVersion
        }
        return copy
    }

    private static func needsChapterMigration(_ progress: PathLessonProgress) -> Bool {
        if progress.chapterProgress.isEmpty {
            return progress.stepIndex > 0 || progress.isCompleted
        }
        return progress.chapterProgress["legacy"] != nil
    }

    static func migrateLessonProgressToChapters(
        _ lessonProgress: PathLessonProgress,
        lesson: PathLesson
    ) -> PathLessonProgress {
        guard !lesson.chapters.isEmpty else { return lessonProgress }

        var migrated = lessonProgress

        if lessonProgress.isCompleted {
            migrated.chapterProgress = Dictionary(
                uniqueKeysWithValues: lesson.chapters.map { chapter in
                    var chapterProgress = PathChapterProgress.fresh(chapterID: chapter.id)
                    chapterProgress.isCompleted = true
                    chapterProgress.completedAt = lessonProgress.completedAt
                    return (chapter.id, chapterProgress)
                }
            )
            migrated.currentChapterID = lesson.chapters.last?.id
            return migrated
        }

        let targetChapterID = mapLegacyStepToChapterID(lesson: lesson, stepIndex: lessonProgress.stepIndex)
        let localStep = chapterStepIndex(
            lesson: lesson,
            chapterID: targetChapterID,
            globalStepIndex: lessonProgress.stepIndex
        )
        let targetChapterNumber = lesson.chapter(withID: targetChapterID)?.number ?? 1

        var chapterProgress: [String: PathChapterProgress] = [:]
        for chapter in lesson.chapters {
            var progress = PathChapterProgress.fresh(chapterID: chapter.id)
            if chapter.number < targetChapterNumber {
                progress.isCompleted = true
            } else if chapter.id == targetChapterID {
                progress.stepIndex = localStep
                progress.quizChineseIndex = lessonProgress.quizChineseIndex
                progress.quizTranslationIndex = lessonProgress.quizTranslationIndex
                progress.exampleIndex = lessonProgress.exampleIndex
                progress.activityIndex = lessonProgress.activityIndex
                progress.chineseQuizResults = lessonProgress.chineseQuizResults
                progress.translationQuizResults = lessonProgress.translationQuizResults
            }
            chapterProgress[chapter.id] = progress
        }

        migrated.chapterProgress = chapterProgress
        migrated.currentChapterID = targetChapterID
        return migrated
    }

    static func mapLegacyStepToChapterID(lesson: PathLesson, stepIndex: Int) -> String {
        var cursor = 0
        for chapter in lesson.chapters {
            let chapterSteps = PathLessonFlowResolver.resolveChapter(chapter, lesson: lesson).count
            if stepIndex < cursor + chapterSteps {
                return chapter.id
            }
            cursor += chapterSteps
        }
        return lesson.chapters.first?.id ?? "legacy"
    }

    static func chapterStepIndex(lesson: PathLesson, chapterID: String, globalStepIndex: Int) -> Int {
        var cursor = 0
        for chapter in lesson.chapters {
            let count = PathLessonFlowResolver.resolveChapter(chapter, lesson: lesson).count
            if chapter.id == chapterID {
                return max(0, globalStepIndex - cursor)
            }
            cursor += count
        }
        return 0
    }
}
