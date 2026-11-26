//
//  TrackingUITests.swift
//  TrackingUITests
//
//  Created by Christian-SDGKU on 09/11/26.
//

import XCTest

final class TrackingUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLaunchEnglish() {
        app.launchArguments = ["-AppleLanguages", "(en)"]
        app.launch()
        
        let header = app.staticTexts["WELCOME TO THE TRACKING APP"]
        XCTAssertTrue(header.exists, "The english header was not found")
    }
    
    func testLaunchRussian() {
        app.launchArguments = ["-AppleLanguages", "(ru)"]
        app.launch()
        
        let header = app.staticTexts["ДОБРО ПОЖАЛОВАТЬ В ПРИЛОЖЕНИЕ ДЛЯ ОТСЛЕЖИВАНИЯ"]
        XCTAssertTrue(header.exists, "The russian header was not found")
    }
    
    func testLaunchArabic() {
        app.launchArguments = ["-AppleLanguages", "(ar)"]
        app.launch()
        
        let header = app.staticTexts["مرحباً بك في تطبيق التتبع"]
        XCTAssertTrue(header.exists, "The arabic header was not found")
    }
    
    func testCreateNewGroup() {
        app.launchArguments = ["-AppleLanguages", "(en)"]
        app.launch()
        
        let profile = app.buttons["SelectProfile_Professor"]
        XCTAssertTrue(profile.exists)
        profile.tap()
        
        let addButton = app.buttons["AddGroupButton"]
        XCTAssertTrue(addButton.exists)
        addButton.tap()
        
        let groupName = app.textFields["GroupNameTextField"]
        groupName.tap()
        groupName.typeText("Automation Test")
        
        app.buttons["SaveButton"].tap()
        XCTAssertTrue(app.buttons["GroupLink_Automation Test"].exists)
    }
}
