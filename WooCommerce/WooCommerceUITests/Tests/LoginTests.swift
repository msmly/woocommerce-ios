import XCTest

class LoginTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false

        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments = ["logout-at-launch", "disable-animations", "mocked-wpcom-api"]
        app.launch()
    }

    func testEmailPasswordLoginLogout() {
        // Log in with email and password
        WelcomeScreen()
        .selectLogin()
        .proceedWith(email: TestCredentials.emailAddress)
        .proceedWithPassword()
        .proceedWith(password: TestCredentials.password)

        // Login epilogue
        .verifyEpilogueDisplays(displayName: TestCredentials.displayName, siteUrl: TestCredentials.siteUrl)
        .continueWithSelectedSite()

        // Log out
        .goToSettings()
        .verifySelectedStoreDisplays(siteUrl: TestCredentials.siteUrl, displayName: TestCredentials.displayName)
        .logOut()

        XCTAssert(WelcomeScreen.isLoaded())
    }
}
