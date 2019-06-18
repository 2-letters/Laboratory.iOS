//
//  LabEquipmentEditUITest.swift
//  LaboratoryUITests
//
//  Created by Huy Vo on 6/16/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

class LabEquipmentEditUITest: MyUITestDelegate {

    var app: XCUIApplication!
    var thisViewController: MyViewController!
    var usingQuantityTextField: XCUIElement!
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        thisViewController = .labEquipmentEdit
        goToLabEquipmentEditViewController()
        usingQuantityTextField = app.textFields[AccessibilityId.labEquipmentEditUsingQuantityTextField.value]
    }
    
    override func tearDown() {
        app = nil
        thisViewController = nil
        usingQuantityTextField = nil
        super.tearDown()
    }
    
    func testViewsExist() {
        let saveBtn = app.buttons[AccessibilityId.labEquipmentEditSaveButton.value]
        let decreaseBtn = app.buttons[AccessibilityId.labEquipmentEditDecreaseButton.value]
        let increaseBtn = app.buttons[AccessibilityId.labEquipmentEditIncreaseButton.value]
        let removeBtn = app.buttons[AccessibilityId.labEquipmentEditRemoveButton.value]
        let equipmentInfoView = app.otherElements[AccessibilityId.labEquipmentEditNameLabel.value]
        let equipmentImageView = app.images[AccessibilityId.labEquipmentEditEquipmentImageView.value]
        
        XCTAssertTrue(saveBtn.exists)
        XCTAssertTrue(decreaseBtn.exists)
        XCTAssertTrue(increaseBtn.exists)
        XCTAssertTrue(removeBtn.exists)
        // todo: fail
        XCTAssertTrue(equipmentInfoView.exists)
        XCTAssertTrue(usingQuantityTextField.exists)
        XCTAssertTrue(equipmentImageView.exists)
    }
    
    func testDismissKeyboard() {
        usingQuantityTextField.tap()
        XCTAssert(app.keyboards.count > 0)
        usingQuantityTextField.typeSomeText()
        
        tapOutside()
        // todo: fail
        XCTAssertEqual(app.keyboards.count, 0)
        
        usingQuantityTextField.tap()
        XCTAssert(app.keyboards.count > 0)
        
        swipeView(inVC: thisViewController)
        XCTAssertEqual(app.keyboards.count, 0)
    }
}
