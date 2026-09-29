import XCTest
@testable import HanziPlus

final class PathCourseChapterTests: XCTestCase {

    func testPathCourseLoadsFifteenLessons() {
        guard let course = PathCourseLoader.loadCourse() else {
            XCTFail("Missing path course")
            return
        }
        XCTAssertEqual(course.totalLessons, 15)
        XCTAssertEqual(course.lessons.count, 15)
    }

    func testAllLessonsHaveExplicitChapters() {
        for number in 1...15 {
            let lesson = PathCourseLoader.loadLesson(fileName: String(format: "lesson_%02d", number))
            XCTAssertNotNil(lesson, "Missing lesson \(number)")
            XCTAssertFalse(lesson?.chapters.isEmpty ?? true, "Lesson \(number) must have chapters")
        }
    }

    func testChaptersRespectMaxNewWordCount() {
        for number in 1...15 {
            guard let lesson = PathCourseLoader.loadLesson(fileName: String(format: "lesson_%02d", number)) else {
                continue
            }
            for chapter in lesson.chapters {
                XCTAssertLessThanOrEqual(
                    chapter.newWordCount,
                    12,
                    "Lesson \(number) chapter \(chapter.number) has \(chapter.newWordCount) counted words"
                )
            }
        }
    }

    func testLessonOneHasToneGuideAndGrammarCards() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01") else {
            XCTFail("Missing lesson 1")
            return
        }

        XCTAssertEqual(lesson.chapters.count, 4)
        XCTAssertNotNil(lesson.chapters.first?.toneGuide)

        let grammarIDs = lesson.chapters.compactMap(\.grammarCard?.id)
        XCTAssertTrue(grammarIDs.contains("l01_greeting"))
        XCTAssertTrue(grammarIDs.contains("l01_ma_question"))
    }

    func testLessonOneTranslationCompleteness() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01") else {
            XCTFail("Missing lesson 1")
            return
        }

        for language in ContentLanguageCode.allCases {
            for chapter in lesson.chapters {
                XCTAssertFalse(chapter.title.localizedValue(language: language).isEmpty)
                if let goal = chapter.goal {
                    XCTAssertFalse(goal.localizedValue(language: language).isEmpty)
                }
            }
        }
    }

    func testChapterProgressPersists() {
        let store = PathCourseStore()
        store.resetForPreviews()

        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01"),
              let chapter = lesson.chapters.first else {
            XCTFail("Missing lesson 1")
            return
        }

        store.startChapter(lessonID: lesson.id, chapterID: chapter.id)
        store.updateChapter(lesson.id, chapterID: chapter.id) { progress in
            progress.stepIndex = 2
            progress.quizChineseIndex = 1
        }

        let reloaded = PathCourseStore()
        let saved = reloaded.chapterProgress(for: lesson.id, chapterID: chapter.id)
        XCTAssertEqual(saved.stepIndex, 2)
        XCTAssertEqual(saved.quizChineseIndex, 1)
    }

    func testLegacyProgressMigratesToChapters() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01") else {
            XCTFail("Missing lesson 1")
            return
        }

        let legacy = PathLessonProgress(
            lessonID: lesson.id,
            currentChapterID: nil,
            stepIndex: 12,
            quizChineseIndex: 1,
            quizTranslationIndex: 0,
            exampleIndex: 0,
            activityIndex: 0,
            chineseQuizResults: [:],
            translationQuizResults: [:],
            chapterProgress: [:],
            pendingMistakes: [],
            isCompleted: false,
            completedAt: nil
        )

        let migrated = PathCourseProgressMigration.migrateLessonProgressToChapters(legacy, lesson: lesson)
        XCTAssertNotNil(migrated.currentChapterID)
        XCTAssertFalse(migrated.chapterProgress.isEmpty)
        XCTAssertNil(migrated.chapterProgress["legacy"])
    }

    func testCompletedLegacyLessonMarksAllChaptersComplete() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01") else {
            XCTFail("Missing lesson 1")
            return
        }

        var legacy = PathLessonProgress.fresh(lessonID: lesson.id)
        legacy.isCompleted = true
        legacy.completedAt = Date()

        let migrated = PathCourseProgressMigration.migrateLessonProgressToChapters(legacy, lesson: lesson)
        XCTAssertTrue(lesson.chapters.allSatisfy {
            migrated.chapterProgress[$0.id]?.isCompleted == true
        })
    }

    func testSentenceBuilderEvaluator() {
        let activity = PathSentenceBuilderActivity(
            id: "test_sb",
            prompt: PathLocalizedText(values: ["en": "Build"]),
            tokens: [
                PathSentenceBuilderToken(id: "t0", text: "你"),
                PathSentenceBuilderToken(id: "t1", text: "好"),
                PathSentenceBuilderToken(id: "t2", text: "！"),
            ],
            correctOrder: ["t0", "t1", "t2"],
            resultHanzi: "你好！",
            resultPinyin: "Nǐ hǎo!",
            resultTranslation: PathLocalizedText(values: ["en": "Hello!"]),
            explanation: nil
        )

        XCTAssertTrue(
            PathSentenceBuilderEvaluator.isCorrect(
                selectedOrder: ["t0", "t1", "t2"],
                activity: activity
            )
        )
        XCTAssertFalse(
            PathSentenceBuilderEvaluator.isCorrect(
                selectedOrder: ["t1", "t0", "t2"],
                activity: activity
            )
        )
    }

    func testFillBlankEvaluator() {
        let activity = PathFillBlankActivity(
            id: "test_fb",
            prompt: PathLocalizedText(values: ["en": "Choose"]),
            template: "你___？",
            blankToken: "___",
            options: ["吗", "的", "很", "也"],
            correctOption: "吗",
            resultHanzi: "你吗？",
            resultPinyin: "Nǐ ma?",
            resultTranslation: PathLocalizedText(values: ["en": "You?"]),
            explanation: nil,
            relatedVocabularyID: nil
        )

        XCTAssertTrue(PathFillBlankEvaluator.isCorrect(selected: "吗", activity: activity))
        XCTAssertFalse(PathFillBlankEvaluator.isCorrect(selected: "的", activity: activity))
    }

    func testDialogueOrderEvaluator() {
        let activity = PathDialogueOrderActivity(
            id: "test_do",
            prompt: PathLocalizedText(values: ["en": "Order"]),
            lines: [
                .init(id: "a", speaker: "A", hanzi: "你好", pinyin: "Nǐ hǎo", translation: nil),
                .init(id: "b", speaker: "B", hanzi: "你好", pinyin: "Nǐ hǎo", translation: nil),
            ],
            correctOrder: ["a", "b"],
            resultHanzi: "你好\n你好",
            resultPinyin: "Nǐ hǎo / Nǐ hǎo",
            resultTranslation: nil,
            explanation: PathLocalizedText(values: ["en": "Greeting then reply"])
        )

        XCTAssertTrue(PathDialogueOrderEvaluator.isCorrect(selectedOrder: ["a", "b"], activity: activity))
        XCTAssertFalse(PathDialogueOrderEvaluator.isCorrect(selectedOrder: ["b", "a"], activity: activity))
    }

    func testMistakeRecordedAndRemediated() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01"),
              let chapter = lesson.chapters.first(where: { $0.number == 2 }),
              let item = chapter.vocabularyItems.first else {
            XCTFail("Missing lesson content")
            return
        }

        var progress = PathLessonProgress.fresh(lessonID: lesson.id)
        let smartReview = SmartReviewStore()

        PathCourseMistakeRecorder.recordMistake(
            item: item,
            lesson: lesson,
            chapter: chapter,
            kind: .quizChinese,
            progress: &progress,
            smartReviewStore: smartReview
        )

        XCTAssertEqual(progress.pendingMistakes.count, 1)
        XCTAssertFalse(progress.pendingMistakes[0].isRemediated)
        XCTAssertTrue(
            smartReview.isWeak(
                fileName: PathCourseSmartReviewBridge.studySetFileName(for: item.hanzi),
                hanzi: item.hanzi
            )
        )

        let mistakeID = progress.pendingMistakes[0].id
        PathCourseMistakeRecorder.markRemediated(
            mistakeID: mistakeID,
            progress: &progress,
            smartReviewStore: smartReview,
            lessonID: lesson.id
        )

        XCTAssertTrue(progress.pendingMistakes[0].isRemediated)
        XCTAssertTrue(PathCourseMistakeRecorder.activeMistakes(in: progress, chapterID: chapter.id).isEmpty)
    }

    func testLessonUnlockRequiresPriorCompletion() {
        let store = PathCourseStore()
        store.resetForPreviews()
        guard let course = store.course else {
            XCTFail("Missing path course")
            return
        }

        let lesson1 = course.lessons[0]
        let lesson2 = course.lessons[1]

        XCTAssertTrue(store.isLessonUnlocked(lesson1))
        XCTAssertFalse(store.isLessonUnlocked(lesson2))

        store.completeLesson(lesson1.id)
        XCTAssertTrue(store.isLessonUnlocked(lesson2))
    }

    func testLessonElevenExampleTranslationsDecode() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_11") else {
            XCTFail("lesson_11 failed to load")
            return
        }
        XCTAssertGreaterThanOrEqual(lesson.chapters.count, 3)
        XCTAssertEqual(lesson.examples.count, 8)
        let example = lesson.examples.first(where: { $0.hanzi == "他们都是留学生吗？" })
        XCTAssertNotNil(example)
        XCTAssertNotNil(example?.translation)
    }

    func testChapterUnlockRequiresPriorChapter() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01") else {
            XCTFail("Missing lesson 1")
            return
        }

        let store = PathCourseStore()
        store.resetForPreviews()
        store.startLesson(lesson.id)

        let chapter2 = lesson.chapters[1]
        XCTAssertEqual(store.chapterStatus(for: lesson, chapter: chapter2), .locked)

        store.completeChapter(lessonID: lesson.id, chapterID: lesson.chapters[0].id, lesson: lesson)
        XCTAssertNotEqual(store.chapterStatus(for: lesson, chapter: chapter2), .locked)
    }

    @MainActor
    func testToneChapterSkipsMistakeReviewWithoutErrors() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01"),
              let chapter = lesson.chapters.first(where: { $0.number == 1 }) else {
            XCTFail("Missing lesson 1 chapter 1")
            return
        }

        let store = PathCourseStore()
        store.resetForPreviews()
        store.startLesson(lesson.id)
        store.startChapter(lessonID: lesson.id, chapterID: chapter.id)

        let vm = PathChapterViewModel(
            lesson: lesson,
            chapter: chapter,
            pathStore: store,
            smartReviewStore: SmartReviewStore()
        )

        if case .toneGuide = vm.currentStep {
            vm.advance()
        }

        XCTAssertFalse({
            if case .mistakeReview = vm.currentStep { return true }
            return false
        }(), "Tone-only chapter should skip empty mistake review")
        XCTAssertTrue({
            if case .chapterComplete = vm.currentStep { return true }
            return false
        }())
    }

    @MainActor
    func testRestartLessonResetsChapterProgress() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01") else {
            XCTFail("Missing lesson 1")
            return
        }

        let store = PathCourseStore()
        store.resetForPreviews()
        store.startLesson(lesson.id)
        store.completeChapter(lessonID: lesson.id, chapterID: lesson.chapters[0].id, lesson: lesson)

        XCTAssertTrue(store.chapterProgress(for: lesson.id, chapterID: lesson.chapters[0].id).isCompleted)

        store.restartLesson(lesson.id, keepCompleted: false)

        XCTAssertFalse(store.chapterProgress(for: lesson.id, chapterID: lesson.chapters[0].id).isCompleted)
        XCTAssertEqual(store.chapterStatus(for: lesson, chapter: lesson.chapters[0]), .available)
        XCTAssertEqual(store.chapterStatus(for: lesson, chapter: lesson.chapters[1]), .locked)
    }

    @MainActor
    func testAdvanceOnChapterCompleteUnlocksNextChapter() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01"),
              let chapter = lesson.chapters.first(where: { $0.number == 1 }) else {
            XCTFail("Missing lesson 1 chapter 1")
            return
        }

        let steps = PathLessonFlowResolver.resolveChapter(chapter, lesson: lesson)
        guard let completeIndex = steps.firstIndex(where: {
            if case .chapterComplete = $0 { return true }
            return false
        }) else {
            XCTFail("Chapter 1 should end with chapterComplete")
            return
        }

        let store = PathCourseStore()
        store.resetForPreviews()
        store.startLesson(lesson.id)
        store.startChapter(lessonID: lesson.id, chapterID: chapter.id)
        store.updateChapter(lesson.id, chapterID: chapter.id) { $0.stepIndex = completeIndex }

        let vm = PathChapterViewModel(
            lesson: lesson,
            chapter: chapter,
            pathStore: store,
            smartReviewStore: SmartReviewStore()
        )

        XCTAssertFalse(store.chapterProgress(for: lesson.id, chapterID: chapter.id).isCompleted)
        vm.advance()
        XCTAssertTrue(store.chapterProgress(for: lesson.id, chapterID: chapter.id).isCompleted)
        XCTAssertNotEqual(store.chapterStatus(for: lesson, chapter: lesson.chapters[1]), .locked)
    }
}
