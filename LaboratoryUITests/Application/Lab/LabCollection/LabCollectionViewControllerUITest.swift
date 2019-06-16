//
//  LabCollectionViewControllerUITest.swift
//  LaboratoryUITests
//
//  Created by Developers on 6/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

class LabCollectionViewControllerUITest: MyUITest {

    var app: XCUIApplication!
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        goToFirstTab()
    }
    
    func testDismissKeyboard() {
        // test keyboard is shown
        tapSearchBar(inVC: .labCollection)
        XCTAssert(app.keyboards.count > 0)
        typeTextSearchBar(inVC: .labCollection)
        tryCancelSearchBar()
        
        tapOutside()
        XCTAssertEqual(app.keyboards.count, 0)
        
        tapSearchBar(inVC: .labCollection)
        XCTAssert(app.keyboards.count > 0)
        
        swipeView(inVC: .labCollection)
        XCTAssertEqual(app.keyboards.count, 0)
    }
    
    func testFirstCellHittable() {
        let firstCell = app.collectionViews[AccessibilityId.labCollectionView.value].cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.isHittable)
    }
}
