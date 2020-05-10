//
//  EquipmentUserListViewControllerUITest.swift
//  LaboratoryUITests
//
//  Created by Developers on 7/1/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

class EquipmentUserListViewControllerUITest: MyUITestDelegate {

    var app: XCUIApplication!
    var thisViewController: MyViewController!
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        thisViewController = .equipmentUserList
        goToEquipmentUserListVC()
    }
    
    override func tearDown() {
        app = nil
        thisViewController = nil
        super.tearDown()
    }
    
    func testViewsExist() {
        let tableView = app.tables[AccessibilityId.equipmentUserListTableView.description]
        
        XCTAssertTrue(tableView.exists)
    }
    
    func testFirstCellHittable() {
        let firstCell = getFirstCell(inVC: thisViewController)!
        XCTAssertTrue(firstCell.isHittable)
    }
    
    func testDoneButton() {
        // GIVEN
        let doneButton = app.buttons[AccessibilityId.equipmentUserListDoneButton.description]
        
        // WHEN
        XCTAssertTrue(doneButton.exists)
        doneButton.tap()
        
        // THEN
        sleep(2)
        // check if the showed view is equipment info
        let availableTextField = app.textFields[AccessibilityId.equipmentInfoAvailableTextField.description]
        XCTAssertTrue(availableTextField.exists)
    }

}
