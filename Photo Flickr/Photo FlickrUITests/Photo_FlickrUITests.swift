//
//  Photo_FlickrUITests.swift
//  Photo FlickrUITests
//
//  Created by Al-Amin on 2023/04/20.
//

import XCTest

final class Photo_FlickrUITests: XCTestCase {
    
    var app: XCUIApplication!
    var searchField: XCUIElement!
    
    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        app.swipeDown()
        searchField = app.searchFields.firstMatch
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_SearchField_is_enabled() {
        let navigationBar = app.navigationBars["Photos"]
        
        let searchField = navigationBar.searchFields["Search photos"]
        XCTAssert(searchField.isEnabled)
    }
    
    func test_SearchField_exists() {
        XCTAssertTrue(searchField.exists, "Search field not found")
    }
    
    func test_SearchField_NotEmpty() {
        searchField.tap()
        searchField.typeText("Cat")
        
        XCTAssertNotNil(searchField.title)
    }
    
    func test_initial_HomeNavigation_Title() {
        let homeNavigationBar = app.navigationBars["Photos"].title
        XCTAssert(homeNavigationBar == "")
    }
    
    func test_tableView() {
        searchField.tap()
        searchField.typeText("Cat")
        sleep(10)
        let initialTableRows = app.tables.children(matching: .cell).count
        XCTAssert(initialTableRows > 0)
    }
    
    func test_ShareButton_exists() {
        searchField.tap()
        searchField.typeText("Cat")
        sleep(10)
        let lastRowIndex = app.tables.children(matching: .cell).count - 1
        app.tables.cells.element(boundBy: lastRowIndex).tap()
        
        XCTAssert(app.buttons["Share"].exists)
    }
    
    func test_ShareButton_enabled() {
        searchField.tap()
        searchField.typeText("Cat")
        sleep(10)
        let lastRowIndex = app.tables.children(matching: .cell).count - 1
        app.tables.cells.element(boundBy: lastRowIndex).tap()
        
        XCTAssert(app.buttons["Share"].isEnabled)
    }
    
    func test_ImageView_exists() {
        searchField.tap()
        searchField.typeText("Cat")
        sleep(10)
        let lastRowIndex = app.tables.children(matching: .cell).count - 1
        app.tables.cells.element(boundBy: lastRowIndex).tap()
        
        XCTAssert(app.images.firstMatch.exists)
    }
}
