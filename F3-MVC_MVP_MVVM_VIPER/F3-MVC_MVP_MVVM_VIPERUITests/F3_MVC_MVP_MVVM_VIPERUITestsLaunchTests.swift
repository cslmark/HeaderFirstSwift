//
//  F3_MVC_MVP_MVVM_VIPERUITestsLaunchTests.swift
//  F3-MVC_MVP_MVVM_VIPERUITests
//
//  Created by 青枫(陈双林) on 2025/8/19.
//

import XCTest

final class F3_MVC_MVP_MVVM_VIPERUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
