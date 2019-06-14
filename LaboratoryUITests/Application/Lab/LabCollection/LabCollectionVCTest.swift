//
//  LabCollectionVCTest.swift
//  LaboratoryUITests
//
//  Created by Developers on 6/12/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

class LabCollectionVCTest: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
//    func testNavigationBar() {
//        app.launch()
//        let navBar = app.navigationBars[AccessibilityIdentifier.labCollectionNavBar]
//        XCTAssertEqual(navBar.title, MyString.labCollectionTitle)
//    }
}
