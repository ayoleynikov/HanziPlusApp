import XCTest

final class PathCourseUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-ui-testing")
        app.launch()
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 10))
    }

    func testPathCourseOpensFromLearnTab() {
        openLearnTab()
        openPathCourse()

        XCTAssertTrue(waitForAny([
            app.otherElements["path_course_view"],
            app.scrollViews["path_course_view"],
            app.navigationBars.element(boundBy: 0)
        ], timeout: 8))
    }

    func testLessonOneOpensChapterMap() {
        openLearnTab()
        openPathCourse()
        openLesson("lesson_01")

        XCTAssertTrue(
            waitForAny([
                app.otherElements["path_lesson_flow"],
                app.otherElements["path_chapter_map"]
            ], timeout: 8)
        )
        XCTAssertTrue(
            waitForAny([
                app.buttons["path_chapter_1"],
                app.otherElements["path_chapter_1"]
            ], timeout: 6)
        )
    }

    func testLessonOneChapterOneToneGuide() {
        openLearnTab()
        openPathCourse()
        openLesson("lesson_01")
        openChapter(1)

        XCTAssertTrue(
            waitForAny([
                app.otherElements["path_tone_guide"],
                app.buttons["path_continue_button"]
            ], timeout: 10)
        )
        XCTAssertTrue(app.buttons["path_continue_button"].waitForExistence(timeout: 4))
        XCTAssertFalse(app.buttons["path_vocab_speak_button"].exists)
    }

    func testLessonProgressPersistsAfterLeavingFlow() {
        openLearnTab()
        openPathCourse()
        openLesson("lesson_01")
        openChapter(1)

        XCTAssertTrue(app.otherElements["path_tone_guide"].waitForExistence(timeout: 10))
        _ = tapContinueIfPresent()

        // Chapter 1 is short: after tone guide we may land on chapter-complete.
        if app.buttons["path_chapter_complete_button"].waitForExistence(timeout: 3)
            || app.otherElements["path_chapter_complete"].waitForExistence(timeout: 1) {
            let done = app.buttons["path_chapter_complete_button"].firstMatch
            if done.exists {
                done.tap()
            } else if app.buttons["path_continue_button"].exists {
                app.buttons["path_continue_button"].firstMatch.tap()
            }
        } else {
            tapBackToChapterMap()
        }

        XCTAssertTrue(app.otherElements["path_chapter_map"].waitForExistence(timeout: 8))

        openChapter(1)
        XCTAssertFalse(app.otherElements["path_tone_guide"].waitForExistence(timeout: 2))
    }

    func testLessonTwoStaysLockedUntilLessonOneCompletes() {
        openLearnTab()
        openPathCourse()

        let lessonTwo = app.descendants(matching: .any)["path_lesson_lesson_02"].firstMatch
        scrollUntilVisible(lessonTwo)
        XCTAssertTrue(lessonTwo.waitForExistence(timeout: 6))
        lessonTwo.tap()

        XCTAssertFalse(app.otherElements["path_lesson_flow"].waitForExistence(timeout: 2))
    }

    func testVocabularyStudyShowsSpeakButton() {
        openLearnTab()
        openPathCourse()
        openLesson("lesson_01")
        openChapter(2)

        let deadline = Date().addingTimeInterval(20)
        var foundVocabulary = false
        while Date() < deadline {
            if waitForAny([
                app.otherElements["path_vocabulary_study"],
                app.buttons["path_vocab_speak_button"],
                app.descendants(matching: .any)["path_vocab_speak_button"].firstMatch
            ], timeout: 1) {
                foundVocabulary = true
                break
            }
            if !tapContinueIfPresent() {
                break
            }
        }
        XCTAssertTrue(foundVocabulary)
    }

    // MARK: - Navigation

    private func openLearnTab() {
        let learnTab = app.tabBars.buttons["tab_learn"]
        if learnTab.waitForExistence(timeout: 4) {
            learnTab.tap()
            return
        }
        let fallback = app.tabBars.buttons.element(boundBy: 1)
        XCTAssertTrue(fallback.waitForExistence(timeout: 8))
        fallback.tap()
    }

    private func openPathCourse() {
        let targets: [XCUIElement] = [
            app.buttons["path_course_link"],
            app.otherElements["path_course_card"],
            app.buttons["path_course_card"],
            app.staticTexts["Hanzi+ Path"]
        ]

        scrollUntilVisible(targets)
        tapFirstExisting(targets, timeout: 12)
        XCTAssertTrue(
            waitForAny([
                app.otherElements["path_course_view"],
                app.scrollViews["path_course_view"]
            ], timeout: 8)
        )
    }

    private func openLesson(_ id: String) {
        let row = app.buttons["path_lesson_\(id)"].firstMatch
        scrollUntilVisible(row)
        XCTAssertTrue(row.waitForExistence(timeout: 8))
        row.tap()
        XCTAssertTrue(
            waitForAny([
                app.otherElements["path_lesson_flow"],
                app.otherElements["path_chapter_map"],
                app.navigationBars.staticTexts.containing(NSPredicate(format: "label CONTAINS '1'")).firstMatch
            ], timeout: 10)
        )
    }

    private func openChapter(_ number: Int) {
        let button = app.buttons["path_chapter_\(number)"].firstMatch
        let fallback = app.otherElements["path_chapter_\(number)"].firstMatch
        scrollUntilVisible(button.exists ? button : fallback, maxSwipes: 15)
        let target = button.waitForExistence(timeout: 4) ? button : fallback
        XCTAssertTrue(target.waitForExistence(timeout: 8))
        if target.isHittable {
            target.tap()
        } else {
            target.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        }
        XCTAssertTrue(
            waitForAny([
                app.buttons["path_back_to_chapters_button"],
                app.buttons["path_continue_button"],
                app.otherElements["path_tone_guide"],
                app.otherElements["path_vocabulary_study"],
                app.otherElements["path_grammar_card"]
            ], timeout: 10)
        )
    }

    private func leaveLessonFlow(maxBackTaps: Int = 5) {
        for _ in 0 ..< maxBackTaps {
            if waitForAny([
                app.otherElements["path_course_view"],
                app.scrollViews["path_course_view"]
            ], timeout: 1) {
                return
            }

            if app.otherElements["path_chapter_map"].exists {
                let back = app.navigationBars.buttons.element(boundBy: 0)
                if back.waitForExistence(timeout: 1) {
                    back.tap()
                    continue
                }
            }

            let chaptersBack = app.descendants(matching: .any)["path_back_to_chapters_button"].firstMatch
            if chaptersBack.waitForExistence(timeout: 1) {
                chaptersBack.tap()
                continue
            }

            let navBack = app.navigationBars.buttons.element(boundBy: 0)
            if navBack.waitForExistence(timeout: 1) {
                navBack.tap()
            } else {
                break
            }
        }
    }

    private func tapContinueIfPresent() -> Bool {
        let button = app.descendants(matching: .any)["path_continue_button"].firstMatch
        guard button.waitForExistence(timeout: 2) else { return false }
        scrollUntilVisible(button, maxSwipes: 4)
        if button.isHittable {
            button.tap()
        } else {
            button.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        }
        return true
    }

    private func tapContinueButton() {
        let button = app.descendants(matching: .any)["path_continue_button"].firstMatch
        scrollUntilVisible(button, maxSwipes: 6)
        XCTAssertTrue(button.waitForExistence(timeout: 8))
        if button.isHittable {
            button.tap()
        } else {
            button.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        }
    }

    private func advanceUntilVocabularySpeakButton(maxSteps: Int = 6) {
        for _ in 0 ..< maxSteps {
            if app.buttons["path_vocab_speak_button"].exists { return }
            let continueButton = app.buttons["path_continue_button"]
            if continueButton.waitForExistence(timeout: 2) {
                continueButton.tap()
            } else {
                break
            }
        }
    }

    private func tapBackToChapterMap() {
        let button = app.buttons["path_back_to_chapters_button"].firstMatch
        XCTAssertTrue(button.waitForExistence(timeout: 8))
        if button.isHittable {
            button.tap()
        } else {
            button.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        }
    }

    private func scrollUntilVisible(_ element: XCUIElement, maxSwipes: Int = 10) {
        scrollUntilVisible([element], maxSwipes: maxSwipes)
    }

    private func scrollUntilVisible(_ elements: [XCUIElement], maxSwipes: Int = 10) {
        for _ in 0 ..< maxSwipes {
            if elements.contains(where: \.exists) { return }
            app.swipeUp()
        }
    }

    private func tapFirstExisting(_ elements: [XCUIElement], timeout: TimeInterval) {
        let deadline = Date().addingTimeInterval(timeout)
        while Date() < deadline {
            if let match = elements.first(where: { $0.exists }) {
                match.tap()
                return
            }
            RunLoop.current.run(until: Date().addingTimeInterval(0.2))
        }
        XCTFail("Expected one of the path course entry points to exist")
    }

    private func waitForAny(_ elements: [XCUIElement], timeout: TimeInterval) -> Bool {
        let deadline = Date().addingTimeInterval(timeout)
        while Date() < deadline {
            if elements.contains(where: \.exists) { return true }
            RunLoop.current.run(until: Date().addingTimeInterval(0.2))
        }
        return false
    }
}
