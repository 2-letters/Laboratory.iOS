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
        usingQuantityTextField = app.textFields[AccessibilityId.labEquipmentEditUsingQuantityTextField.description]
    }
    
    override func tearDown() {
        app = nil
        thisViewController = nil
        usingQuantityTextField = nil
        super.tearDown()
    }
    
    func testBackButton() {
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        
        XCTAssertTrue(backButton.exists)
        backButton.tap()
    }
    
    func testViewsExist() {
        let saveBtn = app.buttons[AccessibilityId.labEquipmentEditSaveButton.description]
        let decreaseBtn = app.buttons[AccessibilityId.labEquipmentEditDecreaseButton.description]
        let increaseBtn = app.buttons[AccessibilityId.labEquipmentEditIncreaseButton.description]
        let removeBtn = app.buttons[AccessibilityId.labEquipmentEditRemoveButton.description]
        let equipmentInfoView = app.textViews[AccessibilityId.labEquipmentEditNameTextView.description]
        let equipmentImageView = app.images[AccessibilityId.labEquipmentEditEquipmentImageView.description]
        
        XCTAssertTrue(saveBtn.exists)
        XCTAssertTrue(decreaseBtn.exists)
        XCTAssertTrue(increaseBtn.exists)
        XCTAssertTrue(removeBtn.exists)
        XCTAssertNotNil(equipmentInfoView)
        XCTAssertTrue(usingQuantityTextField.exists)
        XCTAssertTrue(equipmentImageView.exists)
    }
    
    func testDismissKeyboard() {
        usingQuantityTextField.tap()
        XCTAssert(app.keyboards.count > 0)
        usingQuantityTextField.typeSomeNumber()
        
        tapOutside(inVC: thisViewController)
        XCTAssertEqual(app.keyboards.count, 0)
        
        usingQuantityTextField.tap()
        XCTAssert(app.keyboards.count > 0)
    }
    
    func testChangingQuantity() {
        // GIVEN
        sleep(2)
        let saveBtn = app.buttons[AccessibilityId.labEquipmentEditSaveButton.description]
        let decreaseBtn = app.buttons[AccessibilityId.labEquipmentEditDecreaseButton.description]
        let increaseBtn = app.buttons[AccessibilityId.labEquipmentEditIncreaseButton.description]
        let removeBtn = app.buttons[AccessibilityId.labEquipmentEditRemoveButton.description]
        let usingQuantity = usingQuantityTextField.value as! String
        
        // WHEN
        decreaseBtn.tap()
        increaseBtn.tap()
        decreaseBtn.tap()
        increaseBtn.tap()
        removeBtn.tap()
        
        usingQuantityTextField.tap()
        usingQuantityTextField.deleteAllText()
        usingQuantityTextField.typeText(usingQuantity)
        tapOutside(inVC: thisViewController)
        
        XCTAssertFalse(saveBtn.isEnabled)
    }
    
    func testExceedAvailable() {
        // WHEN
        usingQuantityTextField.tap()
        usingQuantityTextField.typeSomeNumber(withLength: MyInt.quantityTextLimit + 1)
        tapOutside(inVC: thisViewController)
        
        let usingQuantityText = usingQuantityTextField.value as! String
        // THEN
        // TODO replace this with available quantity
        XCTAssertEqual(Int(usingQuantityText)!, 99999)
    }
    
    func testSaveChange() {
        // GIVEN
        sleep(2)
        let saveBtn = app.buttons[AccessibilityId.labEquipmentEditSaveButton.description]
        let increaseBtn = app.buttons[AccessibilityId.labEquipmentEditIncreaseButton.description]
        
        // WHEN
        increaseBtn.tap()
        
        // THEN
        XCTAssertTrue(saveBtn.isEnabled)
        saveBtn.tap()
        
        // GIVEN
        let doneButton = app.buttons[AccessibilityId.labEquipmentSelectionDoneButton.description]

        // THEN
        XCTAssertTrue(doneButton.exists)
        doneButton.tap()
    }
}
