import XCTest

final class HanziPlusLaunchTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAppLaunchesAndShowsRootInterface() {
        let app = XCUIApplication()
        app.launchArguments.append("-ui-testing")
        app.launch()

        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 10))
        XCTAssertTrue(
            app.tabBars.firstMatch.waitForExistence(timeout: 8)
                || app.buttons.firstMatch.waitForExistence(timeout: 8)
        )
    }

    func testTodayShowsDailyPlanSection() {
        let app = XCUIApplication()
        app.launchArguments.append("-ui-testing")
        app.launch()

        let todayTab = app.tabBars.buttons.element(boundBy: 0)
        XCTAssertTrue(todayTab.waitForExistence(timeout: 8))
        todayTab.tap()

        XCTAssertTrue(
            app.staticTexts.matching(
                NSPredicate(format: "label CONTAINS[c] 'Learn' OR label CONTAINS[c] 'Учить' OR label CONTAINS[c] 'Aprender'")
            ).firstMatch.waitForExistence(timeout: 8)
        )
    }
}
