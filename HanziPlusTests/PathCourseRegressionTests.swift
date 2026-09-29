import XCTest
@testable import HanziPlus

final class PathCourseRegressionTests: XCTestCase {

    func testLessonsFiveNineTwelveIncludeQuizzesInVocabularyChapter() {
        for number in [5, 9, 12] {
            guard let lesson = PathCourseLoader.loadLesson(fileName: String(format: "lesson_%02d", number)) else {
                XCTFail("Missing lesson \(number)")
                continue
            }

            let quizChapters = lesson.chapters.filter { chapter in
                chapter.sections.contains { section in
                    if case .quizChineseToTranslation = section { return true }
                    if case .quizTranslationToChinese = section { return true }
                    return false
                }
            }

            XCTAssertFalse(quizChapters.isEmpty, "Lesson \(number) must include a quiz chapter")
            XCTAssertTrue(
                quizChapters.contains(where: \.hasQuizableVocabulary),
                "Lesson \(number) quiz must be attached to a chapter with vocabulary"
            )
        }
    }

    func testEachLessonHasBetweenTwoAndFourChapters() {
        for number in 1 ... 15 {
            guard let lesson = PathCourseLoader.loadLesson(fileName: String(format: "lesson_%02d", number)) else {
                continue
            }
            XCTAssertGreaterThanOrEqual(lesson.chapters.count, 2, "Lesson \(number) has too few chapters")
            XCTAssertLessThanOrEqual(lesson.chapters.count, 4, "Lesson \(number) has too many chapters")
        }
    }

    func testNoCompletionOnlyChapters() {
        for number in 1 ... 15 {
            guard let lesson = PathCourseLoader.loadLesson(fileName: String(format: "lesson_%02d", number)) else {
                continue
            }

            for chapter in lesson.chapters {
                let hasToneGuide = chapter.toneGuide != nil
                let hasSubstantiveSection = chapter.sections.contains { section in
                    switch section {
                    case .completion:
                        return false
                    default:
                        return true
                    }
                }
                XCTAssertTrue(
                    hasToneGuide || hasSubstantiveSection,
                    "Lesson \(number) chapter \(chapter.number) is completion-only"
                )
            }
        }
    }

    func testLessonTwoHasGrammarCardAfterEnrichment() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_02") else {
            XCTFail("Missing lesson 2")
            return
        }

        XCTAssertTrue(
            lesson.chapters.contains { $0.grammarCard != nil },
            "Lesson 2 should include grammar cards from the library"
        )
    }

    func testFillBlankFactoryDoesNotCreateBrokenChinaTemplate() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_02") else {
            XCTFail("Missing lesson 2")
            return
        }

        for chapter in lesson.chapters {
            for activity in chapter.activities {
                if case .fillBlank(let fill) = activity {
                    XCTAssertFalse(
                        fill.resultHanzi.contains("你中国吗"),
                        "Broken fill-blank sentence: \(fill.resultHanzi)"
                    )
                    XCTAssertNotNil(fill.explanation, "Fill blank should include explanation")
                }
            }
        }
    }

    func testLessonOneFillBlankExplainsParticleMa() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01") else {
            XCTFail("Missing lesson 1")
            return
        }

        let fillBlanks = lesson.chapters
            .flatMap(\.activities)
            .compactMap { activity -> PathFillBlankActivity? in
                if case .fillBlank(let value) = activity { return value }
                return nil
            }

        guard let maActivity = fillBlanks.first(where: { $0.correctOption == "吗" }) else {
            XCTFail("Expected a fill-blank activity for 吗 in lesson 1")
            return
        }

        XCTAssertEqual(maActivity.resultHanzi, "你好吗？")
        XCTAssertTrue(maActivity.explanation?.localizedValue().contains("吗") == true)
    }

    func testVocabularyExplanationUsesPerLanguageTranslations() throws {
        let itemJSON = """
        {
          "id": "nihao",
          "hanzi": "你好",
          "pinyin": "nǐ hǎo",
          "translation": {
            "ru": "привет",
            "en": "hello",
            "es": "hola",
            "pt-BR": "olá"
          }
        }
        """
        let item = try JSONDecoder().decode(PathVocabularyItem.self, from: Data(itemJSON.utf8))
        let explanation = PathActivityExplanationBuilder.vocabulary(item: item)

        XCTAssertTrue(explanation.localizedValue(language: .en).contains("hello"))
        XCTAssertFalse(explanation.localizedValue(language: .en).contains("привет"))
        XCTAssertTrue(explanation.localizedValue(language: .ru).contains("привет"))
        XCTAssertTrue(explanation.localizedValue(language: .es).contains("hola"))
        XCTAssertTrue(explanation.localizedValue(language: .ptBR).contains("olá"))
    }

    func testLessonOneSkipsMeaninglessDialogueOrder() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01"),
              let chapter = lesson.chapters.first(where: { $0.number == 2 }) else {
            XCTFail("Missing lesson 1 chapter 2")
            return
        }

        let hasDialogueOrder = chapter.activities.contains { activity in
            if case .dialogueOrder = activity { return true }
            return false
        }
        XCTAssertFalse(hasDialogueOrder, "Identical greeting lines should not create a dialogue-order quiz")

        let hasSentenceBuilder = chapter.activities.contains { activity in
            if case .sentenceBuilder = activity { return true }
            return false
        }
        XCTAssertTrue(hasSentenceBuilder, "Chapter 2 should still practice building 你好")
    }

    func testPathCourseMistakeAppearsInReviewWords() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_05"),
              let chapter = lesson.chapters.first(where: { $0.hasQuizableVocabulary }),
              let item = chapter.vocabularyItems.first else {
            XCTFail("Missing lesson content")
            return
        }

        var progress = PathLessonProgress.fresh(lessonID: lesson.id)
        let smartReview = SmartReviewStore()
        let learnedStore = LearnedWordsStore()

        PathCourseMistakeRecorder.recordMistake(
            item: item,
            lesson: lesson,
            chapter: chapter,
            kind: .fillBlank,
            progress: &progress,
            smartReviewStore: smartReview
        )

        let studySet = SampleStudySets.pathCourse
        XCTAssertTrue(smartReview.isWeak(fileName: studySet.fileName, hanzi: item.hanzi))
        XCTAssertTrue(
            smartReview.reviewWords(for: studySet, learnedStore: learnedStore).contains { $0.hanzi == item.hanzi },
            "Weak path word \(item.hanzi) should appear in reviewWords"
        )
    }

    func testPathCourseStudySetContainsAllLessonVocabulary() {
        let pathWords = Set(
            (1 ... 15).compactMap { number -> [String]? in
                guard let lesson = PathCourseLoader.loadLesson(fileName: String(format: "lesson_%02d", number)) else {
                    return nil
                }
                return lesson.chapters
                    .flatMap(\.vocabularyItems)
                    .filter(\.countsInLessonTotal)
                    .map(\.hanzi)
            }.flatMap { $0 }
        )
        let studySetWords = Set(WordLoader.load(fileName: SampleStudySets.pathCourse.fileName).map(\.hanzi))
        let missing = pathWords.subtracting(studySetWords)
        XCTAssertTrue(missing.isEmpty, "path_course.json missing: \(missing.sorted())")
    }

    func testChapterExamplesAreCappedInFlow() {
        for number in 1 ... 15 {
            guard let lesson = PathCourseLoader.loadLesson(fileName: String(format: "lesson_%02d", number)) else {
                continue
            }
            let flowExamples = lesson.chapters.reduce(0) { $0 + $1.examplesInSections.count }
            XCTAssertLessThanOrEqual(flowExamples, 12, "Lesson \(number) has \(flowExamples) in-flow examples")
            for chapter in lesson.chapters {
                XCTAssertLessThanOrEqual(
                    chapter.examplesInSections.count,
                    8,
                    "Lesson \(number) chapter \(chapter.number) has \(chapter.examplesInSections.count) examples"
                )
            }
        }
    }

    func testSentenceBuilderUsesUniqueTokenIDsForDuplicateCharacters() {
        let activity = PathSentenceBuilderActivity(
            id: "test_sb",
            prompt: PathLocalizedText(values: ["en": "Build"]),
            tokens: [
                PathSentenceBuilderToken(id: "t0", text: "你"),
                PathSentenceBuilderToken(id: "t1", text: "好"),
                PathSentenceBuilderToken(id: "t2", text: "你"),
            ],
            correctOrder: ["t0", "t1", "t2"],
            resultHanzi: "你好你",
            resultPinyin: "Nǐ hǎo nǐ",
            resultTranslation: PathLocalizedText(values: ["en": "Hi you"]),
            explanation: nil
        )

        XCTAssertTrue(
            PathSentenceBuilderEvaluator.isCorrect(selectedOrder: ["t0", "t1", "t2"], activity: activity)
        )
        XCTAssertFalse(
            PathSentenceBuilderEvaluator.isCorrect(selectedOrder: ["t2", "t1", "t0"], activity: activity)
        )
    }

    func testSentenceBuilderUsesUniqueTokenIDsAcrossCourse() {
        for number in 2 ... 15 {
            guard let lesson = PathCourseLoader.loadLesson(fileName: String(format: "lesson_%02d", number)) else {
                continue
            }

            for chapter in lesson.chapters {
                for activity in chapter.activities {
                    guard case .sentenceBuilder(let builder) = activity else { continue }
                    XCTAssertEqual(
                        Set(builder.tokens.map(\.id)).count,
                        builder.tokens.count,
                        "Duplicate token IDs in lesson \(number) chapter \(chapter.number)"
                    )
                    XCTAssertEqual(builder.correctOrder.count, builder.tokens.count)
                }
            }
        }
    }

    func testSentenceBuilderKeepsMultiCharacterVocabularyBlocks() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_03") else {
            XCTFail("Missing lesson 3")
            return
        }

        let builders = lesson.chapters
            .flatMap(\.activities)
            .compactMap { activity -> PathSentenceBuilderActivity? in
                if case .sentenceBuilder(let value) = activity { return value }
                return nil
            }

        XCTAssertFalse(builders.isEmpty, "Expected at least one sentence builder in lesson 3")
        XCTAssertTrue(
            builders.contains { $0.tokens.contains { $0.text.count > 1 } },
            "Sentence builder should preserve multi-character lexical blocks"
        )
    }

    func testLessonsElevenToFourteenLastChapterShowsInFlowExamples() {
        for number in 11 ... 14 {
            guard let lesson = PathCourseLoader.loadLesson(fileName: String(format: "lesson_%02d", number)),
                  let lastChapter = lesson.chapters.last else {
                XCTFail("Missing lesson \(number)")
                continue
            }

            XCTAssertEqual(
                lastChapter.examplesInSections.count,
                8,
                "Lesson \(number) final chapter should show 8 in-flow examples"
            )

            let steps = PathLessonFlowResolver.resolveChapter(lastChapter, lesson: lesson)
            XCTAssertTrue(
                steps.contains { step in
                    if case .examples = step { return true }
                    return false
                },
                "Lesson \(number) final chapter must include an examples step"
            )
        }
    }

    func testChapterExamplesNeverUseAdditionalGroup() {
        for number in 1 ... 15 {
            guard let lesson = PathCourseLoader.loadLesson(fileName: String(format: "lesson_%02d", number)) else {
                continue
            }
            for chapter in lesson.chapters {
                for section in chapter.sections {
                    guard case .examples(let items) = section else { continue }
                    XCTAssertFalse(
                        items.contains { $0.group == "additional" },
                        "Lesson \(number) chapter \(chapter.number) must not hide examples with group 'additional'"
                    )
                }
            }
        }
    }

    @MainActor
    func testMistakeReviewSkippedWhenChapterHasNoMistakes() {
        for number in 1 ... 15 {
            guard let lesson = PathCourseLoader.loadLesson(fileName: String(format: "lesson_%02d", number)) else {
                continue
            }

            for chapter in lesson.chapters {
                let steps = PathLessonFlowResolver.resolveChapter(chapter, lesson: lesson)
                guard let mistakeIndex = steps.firstIndex(where: {
                    if case .mistakeReview = $0 { return true }
                    return false
                }) else { continue }

                let store = PathCourseStore()
                store.resetForPreviews()
                store.startLesson(lesson.id)
                store.startChapter(lessonID: lesson.id, chapterID: chapter.id)
                store.updateChapter(lesson.id, chapterID: chapter.id) { $0.stepIndex = mistakeIndex }

                let vm = PathChapterViewModel(
                    lesson: lesson,
                    chapter: chapter,
                    pathStore: store,
                    smartReviewStore: SmartReviewStore()
                )

                if case .mistakeReview = vm.currentStep {
                    XCTFail("Lesson \(number) chapter \(chapter.number) should skip mistake review without errors")
                }
            }
        }
    }

    func testChapterStepOrderPlacesGrammarBeforeQuiz() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_02"),
              let chapter = lesson.chapters.first(where: { $0.grammarCard != nil }) else {
            XCTFail("Missing grammar chapter")
            return
        }

        let steps = PathLessonFlowResolver.resolveChapter(chapter, lesson: lesson)
        let grammarIndex = steps.firstIndex { if case .grammar = $0 { return true }; return false }
        let quizIndex = steps.firstIndex {
            if case .quizChineseToTranslation = $0 { return true }
            if case .quizTranslationToChinese = $0 { return true }
            return false
        }

        XCTAssertNotNil(grammarIndex)
        if let grammarIndex, let quizIndex {
            XCTAssertLessThan(grammarIndex, quizIndex)
        }
    }
}
