//
//  addRouteUITests.swift
//  WakingRouteUITests
//
//  Created by KwanHoWong on 31/1/2024.
//

import XCTest

final class addRouteUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
        
    func testCheckAllUIFieldsOfAddRouteView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars["Tab Bar"].buttons["Route List"].tap()
        
        let addItemButton = app.navigationBars["Route List"].children(matching: .button).matching(identifier: "Add Item").element(boundBy: 1)
        addItemButton.tap()
        app.textFields["Name"].tap()
        app.textFields["Initial Latitude"].tap()
        app.textFields["Initial Longtitude"].tap()
        app.textFields["Destination Latitude"].tap()
        app.textFields["Destination Longtitude"].tap()
        app.buttons["Cancel"].tap()
        
    }
    
    func testAppShowCreatedRouteCorrectly() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars["Tab Bar"].buttons["Route List"].tap()
        
        let addItemButton = app.navigationBars["Route List"].children(matching: .button).matching(identifier: "Add Item").element(boundBy: 1)
        addItemButton.tap()
        
        let textField = app.textFields["Name"]
        textField.tap()
        textField.typeText("Test")
        app.buttons["Save"].tap()

        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).staticTexts["Test"].tap()

        let resultField = app.textFields["Test"]
        XCTAssertEqual(resultField.value as! String, "Test")
    }
    
    func testAppShowCreatedRouteFailed() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars["Tab Bar"].buttons["Route List"].tap()
        
        let addItemButton = app.navigationBars["Route List"].children(matching: .button).matching(identifier: "Add Item").element(boundBy: 1)
        addItemButton.tap()
        
        let textField = app.textFields["Name"]
        textField.tap()
        textField.typeText("Test")
        app.buttons["Save"].tap()

        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).staticTexts["Test"].tap()

        let resultField = app.textFields["Test"]
        XCTAssertEqual(resultField.value as! String, "")
    }
}
