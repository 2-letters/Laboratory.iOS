//
//  LabEquipmentSelectionViewControllerUITest.swift
//  LaboratoryUITests
//
//  Created by Huy Vo on 6/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

class LabEquipmentSelectionViewControllerUITest: MyUITestDelegate {

    var app: XCUIApplication!
    var thisViewController: MyViewController!
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        thisViewController = .labEquipmentSelection
        
        goToLabEquipmentSelectionViewController()
    }

    override func tearDown() {
        app = nil
        thisViewController = nil
        super.tearDown()
    }
    
    func testViewsExist() {
        let doneButton = app.buttons[AccessibilityId.labEquipmentSelectionDoneButton.value]
        let searchBar = getSearchBar(inVC: thisViewController)!
        let labEquipmentTV = app.tables[AccessibilityId.labEquipmentSelectionTableView.value]
        
        XCTAssertTrue(doneButton.exists)
        XCTAssertTrue(searchBar.exists)
        XCTAssertTrue(labEquipmentTV.exists)
    }
    
    func testDismissKeyboard() {
        // test keyboard is shown
        let searchBar = getSearchBar(inVC: thisViewController)!
        searchBar.tap()
        XCTAssert(app.keyboards.count > 0)
        searchBar.typeSomeText()
        searchBar.cancelTyping()
        
        swipeView(inVC: thisViewController)
        // todo: fail
        XCTAssertEqual(app.keyboards.count, 0)
        
        searchBar.tap()
        XCTAssert(app.keyboards.count > 0)
    }
    
    func testFirstCellHittable() {
        let firstCell = getFirstCell(inVC: thisViewController)!
        // todo: fail
        XCTAssertTrue(firstCell.isHittable)
    }
}
