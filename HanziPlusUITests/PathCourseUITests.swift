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

        XCTAssertTrue(app.otherElements["path_course_view"].waitForExistence(timeout: 8))
        XCTAssertTrue(app.otherElements["path_lesson_lesson_01"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.otherElements["path_lesson_lesson_10"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.otherElements["path_lesson_lesson_11"].waitForExistence(timeout: 4))
        XCTAssertTrue(app.otherElements["path_lesson_lesson_15"].waitForExistence(timeout: 4))
    }

    func testLessonOneOpensWithDialogue() {
        openLearnTab()
        openPathCourse()
        openLesson("lesson_01")

        XCTAssertTrue(app.otherElements["path_lesson_flow"].waitForExistence(timeout: 8))
        XCTAssertTrue(app.staticTexts["你好！"].waitForExistence(timeout: 6))
        XCTAssertTrue(app.buttons["path_continue_button"].waitForExistence(timeout: 4))
    }

    func testLessonProgressPersistsAfterLeavingFlow() {
        openLearnTab()
        openPathCourse()
        openLesson("lesson_01")

        let continueButton = app.buttons["path_continue_button"]
        XCTAssertTrue(continueButton.waitForExistence(timeout: 8))
        continueButton.tap()

        XCTAssertTrue(app.staticTexts["你"].waitForExistence(timeout: 6))

        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        XCTAssertTrue(backButton.waitForExistence(timeout: 4))
        backButton.tap()

        XCTAssertTrue(app.otherElements["path_course_view"].waitForExistence(timeout: 6))
        openLesson("lesson_01")

        XCTAssertTrue(app.staticTexts["你"].waitForExistence(timeout: 6))
        XCTAssertFalse(app.staticTexts["你好！"].waitForExistence(timeout: 1))
    }

    func testLessonTwoStaysLockedUntilLessonOneCompletes() {
        openLearnTab()
        openPathCourse()

        let lessonTwo = app.otherElements["path_lesson_lesson_02"]
        XCTAssertTrue(lessonTwo.waitForExistence(timeout: 6))
        lessonTwo.tap()

        XCTAssertFalse(app.otherElements["path_lesson_flow"].waitForExistence(timeout: 2))
    }

    // MARK: - Navigation

    private func openLearnTab() {
        let learnTab = app.tabBars.buttons.element(boundBy: 1)
        XCTAssertTrue(learnTab.waitForExistence(timeout: 8))
        learnTab.tap()
    }

    private func openPathCourse() {
        let card = app.otherElements["path_course_card"]
        XCTAssertTrue(card.waitForExistence(timeout: 8))
        card.tap()
    }

    private func openLesson(_ id: String) {
        let row = app.otherElements["path_lesson_\(id)"]
        XCTAssertTrue(row.waitForExistence(timeout: 6))
        row.tap()
    }
}
