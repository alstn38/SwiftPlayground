//
//  MSWalkMemoryPracticeUITests.swift
//  MSWalkMemoryPracticeUITests
//
//  Created by 강민수 on 4/2/25.
//

import XCTest

final class MSWalkMemoryPracticeUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//    idTextField.accessibilityIdentifier = "idTextField"
//    passwordTextField.accessibilityIdentifier = "passwordTextField"
//    checkPasswordTextField.accessibilityIdentifier = "checkPasswordTextField"
//    loginButton.accessibilityIdentifier = "loginButton"
    
    func testMS() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["idTextField"].tap()
        app.textFields["idTextField"].typeText("Hello")
        
        app.textFields["passwordTextField"].tap()
        app.textFields["passwordTextField"].typeText("123456")
        
        app.textFields["checkPasswordTextField"].tap()
        app.textFields["checkPasswordTextField"].typeText("123456")
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

