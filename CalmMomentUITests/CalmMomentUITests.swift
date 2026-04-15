import XCTest

final class CalmMomentUITests: XCTestCase {
    func testHappyPathHomeToCheckIn() {
        let app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launch()

        let next = app.buttons["Next"]
        if next.exists {
            next.tap()
            next.tap()
            app.buttons["Get started"].tap()
        }

        app.buttons["Too much around me"].tap()
        app.buttons["This sounds right"].tap()
        app.buttons["Make the environment lighter"].tap()
        app.buttons["Check in"].tap()

        XCTAssertTrue(app.staticTexts["Did this help even a little?"].exists)
    }
}
