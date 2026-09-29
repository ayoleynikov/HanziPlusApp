//
//  PathCourseMistakeRecorder.swift
//  HanziPlus
//

import Foundation

enum PathCourseMistakeRecorder {

    static func smartReviewFileName(lessonID: String) -> String {
        "path-\(lessonID)"
    }

    static func recordMistake(
        item: PathVocabularyItem,
        lesson: PathLesson,
        chapter: PathLessonChapter,
        kind: PathMistakeKind,
        progress: inout PathLessonProgress,
        smartReviewStore: SmartReviewStore
    ) {
        let mistakeID = "\(chapter.id)-\(item.id)-\(kind.rawValue)"
        if let index = progress.pendingMistakes.firstIndex(where: { $0.id == mistakeID }) {
            progress.pendingMistakes[index].mistakeCount += 1
            progress.pendingMistakes[index].isRemediated = false
            progress.pendingMistakes[index].occurredAt = Date()
        } else {
            progress.pendingMistakes.append(
                PathCourseMistake(
                    id: mistakeID,
                    lessonID: lesson.id,
                    chapterID: chapter.id,
                    vocabularyID: item.id,
                    hanzi: item.hanzi,
                    pinyin: item.pinyin,
                    translation: item.translation,
                    kind: kind,
                    occurredAt: Date(),
                    mistakeCount: 1,
                    isRemediated: false
                )
            )
        }

        smartReviewStore.recordAttempt(
            fileName: PathCourseSmartReviewBridge.studySetFileName(for: item.hanzi),
            hanzi: item.hanzi,
            correct: false
        )
    }

    static func markRemediated(mistakeID: String, progress: inout PathLessonProgress, smartReviewStore: SmartReviewStore, lessonID: String) {
        guard let index = progress.pendingMistakes.firstIndex(where: { $0.id == mistakeID }) else { return }
        progress.pendingMistakes[index].isRemediated = true
        let hanzi = progress.pendingMistakes[index].hanzi
        smartReviewStore.recordAttempt(
            fileName: PathCourseSmartReviewBridge.studySetFileName(for: hanzi),
            hanzi: hanzi,
            correct: true
        )
    }

    static func activeMistakes(in progress: PathLessonProgress, chapterID: String) -> [PathCourseMistake] {
        progress.pendingMistakes.filter { $0.chapterID == chapterID && !$0.isRemediated }
    }
}
