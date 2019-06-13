//
//  LaboratoryUITest.swift
//  LaboratoryUITests
//
//  Created by Developers on 6/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

class LaboratoryUITest: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        UITestUtil.goToFirstTab()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
//    func testNavigationBar() {
//        app.launch()
//    }
    
    func testSearchBar() {
        let searchBar = app.otherElements[AccessibilityIdentifier.labCollectionSearchBar]
        
        // test keyboard is shown
        searchBar.tap()
        XCTAssert(app.keyboards.count > 0)
        
        
    }
    
    func testFirstCellHittable() {
        let firstCell = app.collectionViews.element(boundBy: 0)
        XCTAssertTrue(firstCell.isHittable)
    }
    
//    func tapCollection
    
    
    
    
    
    

//    func testSearchBar() {
    
//        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
//        element.children(matching: .other).element.children(matching: .searchField).element.tap()
//
//        let collectionView = element.children(matching: .collectionView).element
//        collectionView.tap()
//
//        let clearTextSearchField = app.searchFields.containing(.button, identifier:"Clear text").element
//
//        let hKey = app/*@START_MENU_TOKEN@*/.keyboards.keys["h"]/*[[".keyboards.keys[\"h\"]",".keys[\"h\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
//        hKey.tap()
//        let searchBar = app.searchFields.
//        XCTAssertEqual(clearTextSearchField., <#T##expression2: Equatable##Equatable#>)
//
//        let lKey = app2/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        lKey.tap()
//        lKey.tap()
//        collectionView.tap()
//        clearTextSearchField.tap()
//        app.searchFields.buttons["Clear text"].tap()
//        collectionView.tap()
//
//        let searchBar =
//    }

}
