//
//  LabCollectionViewControllerUITest.swift
//  LaboratoryUITests
//
//  Created by Developers on 6/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

class LabCollectionViewControllerUITest: MyUITestDelegate {
    var app: XCUIApplication!
    var thisViewController: MyViewController!
    
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        thisViewController = .labCollection
        goToLabCollectionViewController()
    }
    
    override func tearDown() {
        app = nil
        thisViewController = nil
        super.tearDown()
    }
    
    func testViewsExist() {
        let addButton = app.buttons[AccessibilityId.labCollectionAddButton.value]
        let labSearchBar = app.searchFields[AccessibilityId.labCollectionSearchBar.value]
        let labCollectionView = app.collectionViews[AccessibilityId.labCollectionView.value]
        
        XCTAssertTrue(addButton.exists)
        XCTAssertTrue(labSearchBar.exists)
        XCTAssertTrue(labCollectionView.exists)
    }
    
    func testDismissKeyboard() {
        let searchBar = getSearchBar(inVC: thisViewController)!
        
        searchBar.tap()
        XCTAssert(app.keyboards.count > 0)
        searchBar.typeSomeText()
        searchBar.cancelTyping()
        
        tapOutside()
        XCTAssertEqual(app.keyboards.count, 0)
        
        searchBar.tap()
        XCTAssert(app.keyboards.count > 0)
        
        swipeView(inVC: thisViewController)
        XCTAssertEqual(app.keyboards.count, 0)
    }
    
    func testFirstCellHittable() {
        let firstCell = getFirstCell(inVC: thisViewController)!
        XCTAssertTrue(firstCell.isHittable)
    }
}
