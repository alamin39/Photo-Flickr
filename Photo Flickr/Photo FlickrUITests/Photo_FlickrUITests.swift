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
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
