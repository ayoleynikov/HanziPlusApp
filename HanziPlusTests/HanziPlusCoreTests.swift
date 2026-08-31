import XCTest
@testable import HanziPlus

final class HanziPlusCoreTests: XCTestCase {

    func testAllStudySetsDecodeAndContainUniqueHanzi() {
        for studySet in SampleStudySets.all {
            let words = WordLoader.load(fileName: studySet.fileName)
            XCTAssertFalse(words.isEmpty, "\(studySet.fileName) must contain words")
            XCTAssertEqual(
                Set(words.map(\.hanzi)).count,
                words.count,
                "\(studySet.fileName) contains duplicate hanzi identifiers"
            )
            XCTAssertTrue(words.allSatisfy { !$0.hanzi.isEmpty && !$0.pinyin.isEmpty })
        }
    }

    func testDailyLessonSelectionIsDeterministic() {
        let words = (0..<20).map {
            Word(hanzi: "字\($0)", pinyin: "zi4", english: "word \($0)")
        }

        let first = DailyLessonPlanner.selectWords(
            fileName: "test",
            targetCount: 8,
            learnedHanzi: [],
            dateKey: "2026-08-30",
            allWords: words
        )
        let second = DailyLessonPlanner.selectWords(
            fileName: "test",
            targetCount: 8,
            learnedHanzi: [],
            dateKey: "2026-08-30",
            allWords: words
        )

        XCTAssertEqual(first.hanzi, second.hanzi)
        XCTAssertEqual(first.hanzi.count, 8)
        XCTAssertEqual(Set(first.hanzi).count, first.hanzi.count)
    }

    func testDailyLessonUsesLearnedWordsForReviewOnlyWhenNeeded() {
        let words = (0..<6).map {
            Word(hanzi: "词\($0)", pinyin: "ci2", english: "word \($0)")
        }
        let learned = Set(words.prefix(5).map(\.hanzi))

        let selection = DailyLessonPlanner.selectWords(
            fileName: "test",
            targetCount: 4,
            learnedHanzi: learned,
            dateKey: "2026-08-30",
            allWords: words
        )

        XCTAssertEqual(selection.hanzi.first, words.last?.hanzi)
        XCTAssertEqual(selection.hanzi.count, 4)
        XCTAssertFalse(selection.isReviewLesson)
    }

    func testProfileSignatureChangesWithLearningPreferences() {
        var profile = UserProfile.default
        let initial = DailyLessonPlanner.profileSignature(
            profile: profile,
            fileName: DailyLessonPlanner.recommendedFileName(for: profile)
        )

        profile.dailyMinutes = profile.dailyMinutes == .five ? .ten : .five
        let changed = DailyLessonPlanner.profileSignature(
            profile: profile,
            fileName: DailyLessonPlanner.recommendedFileName(for: profile)
        )

        XCTAssertNotEqual(initial, changed)
    }

    func testLegacyListeningPhaseDecodesAsSummary() throws {
        let json = """
        {"dateKey":"2026-08-30","lessonID":"x","fileName":"hsk1","wordHanzi":["你"],"isReviewLesson":false,"phase":"listening","currentIndex":0,"answers":{},"completed":false,"profileSignature":"sig"}
        """
        let session = try JSONDecoder().decode(DailyLessonSession.self, from: Data(json.utf8))
        XCTAssertEqual(session.phase, .summary)
    }

    func testDailyLessonProgressUsesPreviewAndMeaningOnly() {
        var session = DailyLessonSession(
            dateKey: "2026-08-30",
            lessonID: "x",
            fileName: "hsk1",
            wordHanzi: ["你", "好"],
            isReviewLesson: false,
            phase: .preview,
            currentIndex: 0,
            answers: [:],
            completed: false,
            completedAt: nil,
            profileSignature: "sig"
        )

        XCTAssertEqual(session.progressFraction, 0.25, accuracy: 0.001)

        session.phase = .meaning
        session.currentIndex = 1
        XCTAssertEqual(session.progressFraction, 1.0, accuracy: 0.001)
    }

    func testSmartReviewSchedulingMarksWeakWordsAndSchedulesReview() {
        let store = SmartReviewStore()
        let set = SampleStudySets.hsk1
        let word = WordLoader.load(fileName: set.fileName).first!
        let learned = LearnedWordsStore()

        store.recordAttempt(fileName: set.fileName, hanzi: word.hanzi, correct: false)
        XCTAssertTrue(store.isWeak(fileName: set.fileName, hanzi: word.hanzi))

        store.recordAttempt(fileName: set.fileName, hanzi: word.hanzi, correct: true)
        store.recordAttempt(fileName: set.fileName, hanzi: word.hanzi, correct: true)
        XCTAssertFalse(store.isWeak(fileName: set.fileName, hanzi: word.hanzi))

        let dueBeforeLearned = store.dueCount(for: set, learnedStore: learned)
        XCTAssertGreaterThan(dueBeforeLearned, 0)
    }

    func testDailyLessonStoreCreatesTodaySession() {
        let lessonStore = DailyLessonStore()
        let learnedStore = LearnedWordsStore()
        var profile = UserProfile.default

        let session = lessonStore.ensureTodaySession(profile: profile, learnedStore: learnedStore)

        XCTAssertEqual(session.dateKey, DailyLessonPlanner.dateKey())
        XCTAssertFalse(session.wordHanzi.isEmpty)
        XCTAssertEqual(lessonStore.todaySession?.lessonID, session.lessonID)

        profile.dailyMinutes = profile.dailyMinutes == .five ? .ten : .five
        let rebuilt = lessonStore.ensureTodaySession(profile: profile, learnedStore: learnedStore)
        XCTAssertEqual(rebuilt.wordHanzi.count, DailyLessonPlanner.targetWordCount(for: profile))
    }

    func testTodayPlanIncludesReviewWithWeakWordCount() {
        let profile = UserProfile.default
        let actions = TodayPlanBuilder.planActions(
            profile: profile,
            sessionStore: StudySessionStore(),
            lessonSession: nil,
            lessonStatus: .notStarted,
            weakWordsCount: 7
        )

        let review = actions.first { $0.id == "review" }
        XCTAssertNotNil(review)
        XCTAssertTrue(review?.detail.contains("7") == true)
    }

    func testMultipleChoiceOptionsStayStableAcrossReads() {
        let pool = WordLoader.load(fileName: SampleStudySets.hsk1.fileName)
        let word = pool[0]
        let seed = DailyLessonPlanner.stableSeed("test-seed")

        let first = MultipleChoiceHelper.englishOptions(
            correct: word.localizedMeaning,
            pool: pool,
            excluding: word.id,
            seed: seed
        )
        let second = MultipleChoiceHelper.englishOptions(
            correct: word.localizedMeaning,
            pool: pool,
            excluding: word.id,
            seed: seed
        )

        XCTAssertEqual(first, second)
        XCTAssertTrue(first.contains(word.localizedMeaning))
    }

    func testDailyLessonAdvancesToNextUnlearnedWordsNextDay() {
        let words = (0..<12).map {
            Word(hanzi: "学\($0)", pinyin: "xue2", english: "study \($0)")
        }
        let learnedToday = Set(words.prefix(5).map(\.hanzi))

        let today = DailyLessonPlanner.selectWords(
            fileName: "test",
            targetCount: 5,
            learnedHanzi: [],
            dateKey: "2026-08-30",
            allWords: words
        )
        let tomorrow = DailyLessonPlanner.selectWords(
            fileName: "test",
            targetCount: 5,
            learnedHanzi: learnedToday,
            dateKey: "2026-08-31",
            allWords: words
        )

        XCTAssertEqual(today.hanzi, Array(words.prefix(5).map(\.hanzi)))
        XCTAssertEqual(tomorrow.hanzi, Array(words.dropFirst(5).prefix(5).map(\.hanzi)))
        XCTAssertTrue(Set(today.hanzi).isDisjoint(with: Set(tomorrow.hanzi)))
    }

    func testDailyLessonRepeatsUnfinishedWordsIfNotMarkedLearned() {
        let words = (0..<8).map {
            Word(hanzi: "词\($0)", pinyin: "ci2", english: "word \($0)")
        }

        let tomorrow = DailyLessonPlanner.selectWords(
            fileName: "test",
            targetCount: 5,
            learnedHanzi: [],
            dateKey: "2026-08-31",
            allWords: words
        )

        XCTAssertEqual(tomorrow.hanzi, Array(words.prefix(5).map(\.hanzi)))
    }

    func testPathCourseLoaderLoadsLessonOne() {
        let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01")
        XCTAssertNotNil(lesson)
        XCTAssertEqual(lesson?.number, 1)
        XCTAssertEqual(lesson?.sourceLessonNumbers, [1])
        XCTAssertEqual(lesson?.chineseTitle, "你好！")
        XCTAssertEqual(lesson?.allVocabulary.count, 7)
        XCTAssertEqual(lesson?.countedVocabularyTotal, 7)
        XCTAssertEqual(lesson?.dialogues.count, 2)
        XCTAssertEqual(lesson?.examples.count, 3)
    }

    func testPathCourseLoaderLoadsLessonTwo() {
        let lesson = PathCourseLoader.loadLesson(fileName: "lesson_02")
        XCTAssertNotNil(lesson)
        XCTAssertEqual(lesson?.number, 2)
        XCTAssertEqual(lesson?.sourceLessonNumbers, [1, 2])
        XCTAssertEqual(lesson?.chineseTitle, "你忙吗？")
        XCTAssertEqual(lesson?.countedVocabularyTotal, 18)
        XCTAssertEqual(lesson?.dialogues.count, 2)
        XCTAssertEqual(lesson?.examples.count, 4)
    }

    func testPathCourseLoaderLoadsLessonThree() {
        let lesson = PathCourseLoader.loadLesson(fileName: "lesson_03")
        XCTAssertNotNil(lesson)
        XCTAssertEqual(lesson?.number, 3)
        XCTAssertEqual(lesson?.sourceLessonNumbers, [3])
        XCTAssertEqual(lesson?.chineseTitle, "明天见")
        XCTAssertEqual(lesson?.localizedTranslationTitle, "See you tomorrow")
        XCTAssertEqual(lesson?.countedVocabularyTotal, 23)
        XCTAssertFalse(lesson?.dialogues.isEmpty ?? true)
        XCTAssertEqual(lesson?.dialogues.count, 4)
        XCTAssertEqual(lesson?.examples.count, 8)

        let summary = PathCourseLoader.loadCourse()?.lessons.first(where: { $0.number == 3 })
        XCTAssertNotNil(summary)
        XCTAssertTrue(summary?.isAvailable == true)
    }

    func testPathCourseLoaderLoadsLessonFour() {
        let lesson = PathCourseLoader.loadLesson(fileName: "lesson_04")
        XCTAssertNotNil(lesson)
        XCTAssertEqual(lesson?.number, 4)
        XCTAssertEqual(lesson?.sourceLessonNumbers, [4])
        XCTAssertEqual(lesson?.chineseTitle, "你去哪儿")
        XCTAssertEqual(lesson?.localizedTranslationTitle, "Where are you going?")
        XCTAssertEqual(lesson?.countedVocabularyTotal, 25)
        XCTAssertFalse(lesson?.dialogues.isEmpty ?? true)
        XCTAssertEqual(lesson?.dialogues.count, 4)
        XCTAssertEqual(lesson?.examples.count, 20)

        let summary = PathCourseLoader.loadCourse()?.lessons.first(where: { $0.number == 4 })
        XCTAssertNotNil(summary)
        XCTAssertTrue(summary?.isAvailable == true)
    }

    func testPathCourseLoaderLoadsLessonFive() {
        let lesson = PathCourseLoader.loadLesson(fileName: "lesson_05")
        XCTAssertNotNil(lesson)
        XCTAssertEqual(lesson?.number, 5)
        XCTAssertEqual(lesson?.sourceLessonNumbers, [5])
        XCTAssertEqual(lesson?.chineseTitle, "这是王老师")
        XCTAssertEqual(lesson?.localizedTranslationTitle, "This is Teacher Wang")
        XCTAssertEqual(lesson?.countedVocabularyTotal, 17)
        XCTAssertFalse(lesson?.dialogues.isEmpty ?? true)
        XCTAssertEqual(lesson?.dialogues.count, 2)
        XCTAssertEqual(lesson?.examples.count, 17)

        let summary = PathCourseLoader.loadCourse()?.lessons.first(where: { $0.number == 5 })
        XCTAssertNotNil(summary)
        XCTAssertTrue(summary?.isAvailable == true)
    }

    func testPathLessonFlowResolverBuildsLessonOneSteps() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01") else {
            XCTFail("Missing lesson")
            return
        }

        let steps = PathLessonFlowResolver.resolve(lesson)
        XCTAssertFalse(steps.contains(where: {
            if case .vocabularySummary = $0 { return true }
            return false
        }))
        XCTAssertFalse(steps.contains(where: {
            if case .transition = $0 { return true }
            return false
        }))
        XCTAssertTrue(steps.contains(where: {
            if case .examples = $0 { return true }
            return false
        }))
    }

    func testPathLessonFlowResolverBuildsLessonTwoSteps() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_02") else {
            XCTFail("Missing lesson")
            return
        }

        let steps = PathLessonFlowResolver.resolve(lesson)
        XCTAssertTrue(steps.contains(where: {
            if case .transition(PathStrings.continueConversation) = $0 { return true }
            return false
        }))
        XCTAssertTrue(steps.contains(where: {
            if case .vocabularySummary = $0 { return true }
            return false
        }))
        XCTAssertEqual(lesson.resolvedVocabularySummaryGroups().count, 2)
        XCTAssertEqual(lesson.resolvedVocabularySummaryGroups()[0].items.count, 4)
        XCTAssertEqual(lesson.resolvedVocabularySummaryGroups()[1].items.count, 14)
    }

    func testPathCourseStorePersistsLessonProgress() {
        let store = PathCourseStore()
        store.resetForPreviews()

        store.startLesson("lesson_01")
        store.updateLesson("lesson_01") { progress in
            progress.stepIndex = 18
            progress.quizChineseIndex = 2
        }

        let reloaded = PathCourseStore()
        let progress = reloaded.lessonProgress(for: "lesson_01")
        XCTAssertEqual(progress.stepIndex, 18)
        XCTAssertEqual(progress.quizChineseIndex, 2)
    }

    func testPathCourseStorePersistsLessonThreeProgress() {
        let store = PathCourseStore()
        store.resetForPreviews()

        store.startLesson("lesson_03")
        store.updateLesson("lesson_03") { progress in
            progress.stepIndex = 9
            progress.exampleIndex = 2
            progress.quizChineseIndex = 1
        }

        let reloaded = PathCourseStore()
        let progress = reloaded.lessonProgress(for: "lesson_03")
        XCTAssertEqual(progress.stepIndex, 9)
        XCTAssertEqual(progress.exampleIndex, 2)
        XCTAssertEqual(progress.quizChineseIndex, 1)
    }

    func testPathQuizOptionsAreStablePerQuestion() {
        let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01")!
        let item = lesson.allVocabulary[0]
        let candidates = lesson.allVocabulary.filter { $0.id != item.id }.map(\.localizedTranslation)
        let seed: UInt64 = 42

        let first = PathQuizOptionBuilder.translationOptions(
            correct: item.localizedTranslation,
            candidates: candidates,
            seed: seed
        )
        let second = PathQuizOptionBuilder.translationOptions(
            correct: item.localizedTranslation,
            candidates: candidates,
            seed: seed
        )

        XCTAssertEqual(first, second)
        XCTAssertTrue(first.contains(item.localizedTranslation))
        XCTAssertEqual(first.count, 4)
    }

    func testPathLessonLocalizedTranslationTitleUsesAppLanguage() {
        let lesson = PathCourseLoader.loadLesson(fileName: "lesson_01")
        XCTAssertNotNil(lesson)

        let previous = LocalizedContent.currentLanguage
        defer { LocalizedContent.currentLanguage = previous }

        LocalizedContent.currentLanguage = .en
        XCTAssertEqual(lesson?.localizedTranslationTitle, "Hello!")

        LocalizedContent.currentLanguage = .ru
        XCTAssertEqual(lesson?.localizedTranslationTitle, "Привет!")
    }

    func testPathLessonUnlockRequiresPriorCompletion() {
        let store = PathCourseStore()
        store.resetForPreviews()
        guard let course = store.course else {
            XCTFail("Missing path course")
            return
        }

        let lesson1 = course.lessons[0]
        let lesson2 = course.lessons[1]
        let lesson3 = course.lessons[2]

        XCTAssertEqual(lesson1.sourceLessonNumbers, [1])
        XCTAssertEqual(lesson2.sourceLessonNumbers, [1, 2])
        XCTAssertEqual(lesson3.sourceLessonNumbers, [3])
        XCTAssertTrue(store.isLessonUnlocked(lesson1))
        XCTAssertFalse(store.isLessonUnlocked(lesson2))

        store.completeLesson(lesson1.id)
        XCTAssertTrue(store.isLessonUnlocked(lesson2))
        XCTAssertFalse(store.isLessonUnlocked(lesson3))
    }

    func testPathLessonUnlockChainPhaseTwo() {
        let store = PathCourseStore()
        store.resetForPreviews()
        guard let course = store.course else {
            XCTFail("Missing path course")
            return
        }

        guard let lesson1 = course.lessons.first(where: { $0.number == 1 }),
              let lesson2 = course.lessons.first(where: { $0.number == 2 }),
              let lesson3 = course.lessons.first(where: { $0.number == 3 }),
              let lesson4 = course.lessons.first(where: { $0.number == 4 }),
              let lesson5 = course.lessons.first(where: { $0.number == 5 }),
              let lesson6 = course.lessons.first(where: { $0.number == 6 }) else {
            XCTFail("Missing phase-two lessons")
            return
        }

        XCTAssertTrue(lesson3.isAvailable)
        XCTAssertTrue(lesson4.isAvailable)
        XCTAssertTrue(lesson5.isAvailable)
        XCTAssertTrue(lesson6.isAvailable)

        store.completeLesson(lesson1.id)
        store.completeLesson(lesson2.id)
        XCTAssertTrue(store.isLessonUnlocked(lesson3))
        XCTAssertFalse(store.isLessonUnlocked(lesson4))

        store.completeLesson(lesson3.id)
        XCTAssertTrue(store.isLessonUnlocked(lesson4))
        XCTAssertFalse(store.isLessonUnlocked(lesson5))

        store.completeLesson(lesson4.id)
        XCTAssertTrue(store.isLessonUnlocked(lesson5))
        XCTAssertFalse(store.isLessonUnlocked(lesson6))

        store.completeLesson(lesson5.id)
        XCTAssertTrue(store.isLessonUnlocked(lesson6))
    }

    func testPathCourseLoaderLoadsLessonSix() {
        assertPathLessonLoads(
            fileName: "lesson_06",
            number: 6,
            chineseTitle: "我学习汉语",
            vocabularyCount: 39,
            dialogueSectionCount: 4,
            exampleCount: 32
        )
    }

    func testPathCourseLoaderLoadsLessonSeven() {
        assertPathLessonLoads(
            fileName: "lesson_07",
            number: 7,
            chineseTitle: "你吃什么",
            vocabularyCount: 23,
            dialogueSectionCount: 2,
            exampleCount: 31
        )
    }

    func testPathCourseLoaderLoadsLessonEight() {
        assertPathLessonLoads(
            fileName: "lesson_08",
            number: 8,
            chineseTitle: "苹果一斤多少钱",
            vocabularyCount: 23,
            dialogueSectionCount: 2,
            exampleCount: 36
        )
    }

    func testPathCourseLoaderLoadsLessonNine() {
        assertPathLessonLoads(
            fileName: "lesson_09",
            number: 9,
            chineseTitle: "我换人民币",
            vocabularyCount: 20,
            dialogueSectionCount: 2,
            exampleCount: 33
        )
    }

    func testPathCourseLoaderLoadsLessonTen() {
        assertPathLessonLoads(
            fileName: "lesson_10",
            number: 10,
            chineseTitle: "他住哪儿",
            vocabularyCount: 21,
            dialogueSectionCount: 2,
            exampleCount: 35
        )
    }

    func testPathLessonUnlockChainPhaseThree() {
        let store = PathCourseStore()
        store.resetForPreviews()
        guard let course = store.course else {
            XCTFail("Missing path course")
            return
        }

        let lessons = Dictionary(uniqueKeysWithValues: course.lessons.map { ($0.number, $0) })
        for number in 5...10 {
            XCTAssertTrue(lessons[number]?.isAvailable == true, "Lesson \(number) should be available")
        }
        XCTAssertTrue(lessons[11]?.isAvailable == true)

        for number in 1...4 {
            store.completeLesson(lessons[number]!.id)
        }
        XCTAssertFalse(store.isLessonUnlocked(lessons[6]!))

        store.completeLesson(lessons[5]!.id)
        XCTAssertTrue(store.isLessonUnlocked(lessons[6]!))
        XCTAssertFalse(store.isLessonUnlocked(lessons[7]!))

        store.completeLesson(lessons[6]!.id)
        XCTAssertTrue(store.isLessonUnlocked(lessons[7]!))
        XCTAssertFalse(store.isLessonUnlocked(lessons[8]!))

        store.completeLesson(lessons[7]!.id)
        XCTAssertTrue(store.isLessonUnlocked(lessons[8]!))
        XCTAssertFalse(store.isLessonUnlocked(lessons[9]!))

        store.completeLesson(lessons[8]!.id)
        XCTAssertTrue(store.isLessonUnlocked(lessons[9]!))
        XCTAssertFalse(store.isLessonUnlocked(lessons[10]!))

        store.completeLesson(lessons[9]!.id)
        XCTAssertTrue(store.isLessonUnlocked(lessons[10]!))
        XCTAssertFalse(store.isLessonUnlocked(lessons[11]!))

        store.completeLesson(lessons[10]!.id)
        XCTAssertTrue(store.isLessonUnlocked(lessons[11]!))
        XCTAssertFalse(store.isLessonUnlocked(lessons[12]!))
    }

    func testPathLessonUnlockChainPhaseFour() {
        let store = PathCourseStore()
        store.resetForPreviews()
        guard let course = store.course else {
            XCTFail("Missing path course")
            return
        }

        let lessons = Dictionary(uniqueKeysWithValues: course.lessons.map { ($0.number, $0) })
        for number in 11...15 {
            XCTAssertTrue(lessons[number]?.isAvailable == true, "Lesson \(number) should be available")
        }

        for number in 1...10 {
            store.completeLesson(lessons[number]!.id)
        }
        XCTAssertTrue(store.isLessonUnlocked(lessons[11]!))
        XCTAssertFalse(store.isLessonUnlocked(lessons[12]!))

        store.completeLesson(lessons[11]!.id)
        XCTAssertTrue(store.isLessonUnlocked(lessons[12]!))
        XCTAssertFalse(store.isLessonUnlocked(lessons[13]!))

        store.completeLesson(lessons[12]!.id)
        XCTAssertTrue(store.isLessonUnlocked(lessons[13]!))
        XCTAssertFalse(store.isLessonUnlocked(lessons[14]!))

        store.completeLesson(lessons[13]!.id)
        XCTAssertTrue(store.isLessonUnlocked(lessons[14]!))
        XCTAssertFalse(store.isLessonUnlocked(lessons[15]!))

        store.completeLesson(lessons[14]!.id)
        XCTAssertTrue(store.isLessonUnlocked(lessons[15]!))
    }

    func testPathCourseLoaderLoadsLessonFifteen() {
        guard let lesson = PathCourseLoader.loadLesson(fileName: "lesson_15") else {
            XCTFail("Missing lesson 15")
            return
        }

        let originalDialogues = lesson.sections.compactMap { section -> PathDialogue? in
            if case .dialogue(let dialogue, _, _) = section { return dialogue }
            return nil
        }

        XCTAssertEqual(lesson.number, 15)
        XCTAssertEqual(lesson.chineseTitle, "你们公司有多少职员")
        XCTAssertEqual(originalDialogues.count, 2)
        XCTAssertEqual(originalDialogues[0].lines.count, 8)
        XCTAssertEqual(originalDialogues[1].lines.count, 8)
        XCTAssertEqual(lesson.countedVocabularyTotal, 16)
        XCTAssertFalse(lesson.allVocabulary.isEmpty)
        XCTAssertFalse(lesson.examples.isEmpty)
        XCTAssertEqual(lesson.examples.count, 18)

        let summary = PathCourseLoader.loadCourse()?.lessons.first(where: { $0.number == 15 })
        XCTAssertNotNil(summary)
        XCTAssertTrue(summary?.isAvailable == true)
    }

    func testPathCourseStorePersistsLessonFifteenProgress() {
        let store = PathCourseStore()
        store.resetForPreviews()

        store.startLesson("lesson_15")
        store.updateLesson("lesson_15") { progress in
            progress.stepIndex = 6
            progress.exampleIndex = 2
            progress.quizChineseIndex = 1
        }

        let reloaded = PathCourseStore()
        let progress = reloaded.lessonProgress(for: "lesson_15")
        XCTAssertEqual(progress.stepIndex, 6)
        XCTAssertEqual(progress.exampleIndex, 2)
        XCTAssertEqual(progress.quizChineseIndex, 1)
    }

    func testPathCourseLoaderLoadsLessonEleven() {
        assertPathLessonLoads(
            fileName: "lesson_11",
            number: 11,
            chineseTitle: "我们都是留学生",
            vocabularyCount: 22,
            dialogueSectionCount: 3,
            exampleCount: 32
        )
    }

    func testPathCourseLoaderLoadsLessonTwelve() {
        assertPathLessonLoads(
            fileName: "lesson_12",
            number: 12,
            chineseTitle: "你在哪儿学习",
            vocabularyCount: 20,
            dialogueSectionCount: 2,
            exampleCount: 52
        )
    }

    func testPathCourseLoaderLoadsLessonThirteen() {
        assertPathLessonLoads(
            fileName: "lesson_13",
            number: 13,
            chineseTitle: "这是不是中药",
            vocabularyCount: 29,
            dialogueSectionCount: 2,
            exampleCount: 58
        )
    }

    func testPathCourseLoaderLoadsLessonFourteen() {
        assertPathLessonLoads(
            fileName: "lesson_14",
            number: 14,
            chineseTitle: "你的车是新的还是旧的",
            vocabularyCount: 22,
            dialogueSectionCount: 2,
            exampleCount: 29
        )
    }

    func testPathCourseStorePersistsLessonElevenProgress() {
        let store = PathCourseStore()
        store.resetForPreviews()

        store.startLesson("lesson_11")
        store.updateLesson("lesson_11") { progress in
            progress.stepIndex = 8
            progress.exampleIndex = 3
            progress.quizChineseIndex = 1
        }

        let reloaded = PathCourseStore()
        let progress = reloaded.lessonProgress(for: "lesson_11")
        XCTAssertEqual(progress.stepIndex, 8)
        XCTAssertEqual(progress.exampleIndex, 3)
        XCTAssertEqual(progress.quizChineseIndex, 1)
    }

    func testPathCourseStorePersistsLessonSixProgress() {
        let store = PathCourseStore()
        store.resetForPreviews()

        store.startLesson("lesson_06")
        store.updateLesson("lesson_06") { progress in
            progress.stepIndex = 11
            progress.exampleIndex = 4
            progress.quizChineseIndex = 2
        }

        let reloaded = PathCourseStore()
        let progress = reloaded.lessonProgress(for: "lesson_06")
        XCTAssertEqual(progress.stepIndex, 11)
        XCTAssertEqual(progress.exampleIndex, 4)
        XCTAssertEqual(progress.quizChineseIndex, 2)
    }

    func testPathRestartLessonResetsProgressButKeepsCompletion() {
        let store = PathCourseStore()
        store.resetForPreviews()

        store.startLesson("lesson_01")
        store.updateLesson("lesson_01") { progress in
            progress.stepIndex = 12
            progress.quizChineseIndex = 3
        }
        store.completeLesson("lesson_01")

        store.restartLesson("lesson_01")

        let progress = store.lessonProgress(for: "lesson_01")
        XCTAssertEqual(progress.stepIndex, 0)
        XCTAssertEqual(progress.quizChineseIndex, 0)
        XCTAssertTrue(progress.isCompleted)
    }

    private func assertCompletePathTranslation(
        _ translation: PathLocalizedText?,
        context: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertNotNil(translation, context, file: file, line: line)
        guard let translation else { return }

        for code in ContentLanguageCode.allCases {
            let value = translation.localizedValue(language: code)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            XCTAssertFalse(
                value.isEmpty,
                "\(context) missing \(code.rawValue)",
                file: file,
                line: line
            )
        }
    }

    private func assertPathLessonLoads(
        fileName: String,
        number: Int,
        chineseTitle: String,
        vocabularyCount: Int,
        dialogueSectionCount: Int,
        exampleCount: Int,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let lesson = PathCourseLoader.loadLesson(fileName: fileName)
        XCTAssertNotNil(lesson, file: file, line: line)
        XCTAssertEqual(lesson?.number, number, file: file, line: line)
        XCTAssertEqual(lesson?.chineseTitle, chineseTitle, file: file, line: line)
        XCTAssertNotNil(lesson?.localizedTranslationTitle, file: file, line: line)
        XCTAssertEqual(lesson?.countedVocabularyTotal, vocabularyCount, file: file, line: line)
        XCTAssertFalse(lesson?.dialogues.isEmpty ?? true, file: file, line: line)
        XCTAssertEqual(lesson?.dialogues.count, dialogueSectionCount, file: file, line: line)
        XCTAssertEqual(lesson?.examples.count, exampleCount, file: file, line: line)

        let summary = PathCourseLoader.loadCourse()?.lessons.first(where: { $0.number == number })
        XCTAssertNotNil(summary, file: file, line: line)
        XCTAssertTrue(summary?.isAvailable == true, file: file, line: line)
    }

    func testPathCourseAllLessonsHavePhraseTranslations() {
        for number in 1 ... 15 {
            let fileName = String(format: "lesson_%02d", number)
            guard let lesson = PathCourseLoader.loadLesson(fileName: fileName) else {
                XCTFail("Missing lesson \(fileName)")
                continue
            }

            for dialogue in lesson.dialogues {
                for dialogueLine in dialogue.lines {
                    assertCompletePathTranslation(
                        dialogueLine.translation,
                        context: "\(fileName) dialogue: \(dialogueLine.hanzi)"
                    )
                }
            }

            for example in lesson.examples {
                assertCompletePathTranslation(
                    example.translation,
                    context: "\(fileName) example: \(example.hanzi)"
                )
            }
        }
    }
}
