//
//  EquipmentInfoViewControllerUITest.swift
//  LaboratoryUITests
//
//  Created by Developers on 7/2/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

class EquipmentInfoViewControllerUITest: MyUITestDelegate {

    var app: XCUIApplication!
    var thisViewController: MyViewController!
    var editSaveBtn: XCUIElement
    var availableTextField: XCUIElement
    var nameTextView: XCUIElement
    var locationTextView: XCUIElement
    var descriptionTextView: XCUIElement
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        thisViewController = .equipmentInfo
        editSaveBtn = app.buttons[AccessibilityId.equipmentInfoEditSaveButton.description]
        availableTextField = app.textFields[AccessibilityId.equipmentInfoAvailableTextField.description]
        nameTextView = app.textViews[AccessibilityId.equipmentInfoNameTextView.description]
        locationTextView = app.textViews[AccessibilityId.equipmentInfoLocationTextView.description]
        descriptionTextView = app.textViews[AccessibilityId.equipmentInfoDescriptionTextView.description]
    }
    
    override func tearDown() {
        app = nil
        thisViewController = nil
        super.tearDown()
    }

    func testBackButton() {
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        
        XCTAssertTrue(backButton.exists)
        backButton.tap()
        
        sleep(2)
        let equipmentListSearchBar = getSearchBar(inVC: .equipmentList)!
        XCTAssertTrue(equipmentListSearchBar.exists)
    }
    
    func testViewsExist() {
        let imageView = app.images[AccessibilityId.equipmentInfoImageView.description]
        let addImageButton = app.buttons[AccessibilityId.equipmentInfoAddImageButton.description]
        let removeEquipmentButton = app.buttons[AccessibilityId.equipmentInfoRemoveEquipmentButton.description]
        let listOfUserButton = app.buttons[AccessibilityId.equipmentInfoListOfUserButton.description]
        
        XCTAssertTrue(editSaveBtn.exists)
        XCTAssertTrue(availableTextField.exists)
        XCTAssertTrue(nameTextView.exists)
        XCTAssertTrue(locationTextView.exists)
        XCTAssertTrue(descriptionTextView.exists)
        XCTAssertTrue(imageView.exists)
        XCTAssertTrue(addImageButton.exists)
        XCTAssertFalse(addImageButton.isHittable)
        XCTAssertTrue(removeEquipmentButton.exists)
        XCTAssertFalse(removeEquipmentButton.isHittable)
        XCTAssertTrue(listOfUserButton.exists)
    }
    
    func testEditSaveButtonTapped() {
        let addImageButton = app.buttons[AccessibilityId.equipmentInfoAddImageButton.description]
        let removeEquipmentButton = app.buttons[AccessibilityId.equipmentInfoRemoveEquipmentButton.description]
        
        editSaveBtn.tap()
        
        XCTAssertTrue(addImageButton.isHittable)
        XCTAssertTrue(removeEquipmentButton.isHittable)
    }
    
    func testEmptyQuantityBecomeZero() {
        editSaveBtn.tap()
        
        availableTextField.tap()
        availableTextField.deleteAllText()
        tapOutside(inVC: thisViewController)
        
        XCTAssertEqual(availableTextField.value as! String, "0")
    }
    
    func testTextViewAndTextFieldShouldChangeText() {
        editSaveBtn.tap()
        
        // WHEN
        availableTextField.tap()
        availableTextField.deleteAllText()
        availableTextField.typeSomeNumber(withLength: MyInt.nameTextLimit + 1)
        
        // THEN
        let availableText = nameTextView.value as! String
        XCTAssertEqual(availableText.count, MyInt.quantityTextLimit)
        
        // WHEN
        nameTextView.tap()
        nameTextView.deleteAllText()
        nameTextView.typeSomeText(withLength: MyInt.nameTextLimit + 1)
        
        // THEN
        let nameText = nameTextView.value as! String
        XCTAssertEqual(nameText.count, MyInt.nameTextLimit)
        
        // WHEN
        locationTextView.tap()
        locationTextView.deleteAllText()
        locationTextView.typeSomeText(withLength: MyInt.locationTextLimit + 1)
        
        // THEN
        let locationText = locationTextView.value as! String
        XCTAssertEqual(locationText.count, MyInt.locationTextLimit)
        
        // WHEN
        descriptionTextView.tap()
        descriptionTextView.deleteAllText()
        descriptionTextView.typeSomeText(withLength: 501)
        
        // THEN
        let descriptionText = descriptionTextView.value as! String
        XCTAssertEqual(descriptionText.count, MyInt.descriptionTextLimit)
    }
    
    func testInvalidInput() {
        editSaveBtn.tap()
        
        // clear all inputs
        nameTextView.tap()
        nameTextView.deleteAllText()
        descriptionTextView.tap()
        descriptionTextView.deleteAllText()
        
        editSaveBtn.tap()
        sleep(2)
        
        //        let alert = app.alerts[AlertCase.invalidLabInfoInput.description]
        //        XCTAssertTrue(alert.exists)
        // close the alert
        proceedAlertButton(ofCase: .invalidEquipmentInfoInput)
    }
    
//    func testAddEquipmentButtonHittable()  {
//        let addEquipmentButton = app.buttons[AccessibilityId.labInfoAddEquipmentButton.description]
//        sleep(2)
//        XCTAssertTrue(addEquipmentButton.isHittable)
//    }
    
    func testRemoveButton() {
        editSaveBtn.tap()
        
        let removeEquipmentButton = app.buttons[AccessibilityId.equipmentInfoRemoveEquipmentButton.description]
        XCTAssertTrue(removeEquipmentButton.isHittable)
        
        removeEquipmentButton.tap()
        sleep(2)
        
        XCTAssertTrue(app.buttons[AlertString.yes].exists)
        XCTAssertTrue(app.buttons[AlertString.no].exists)
        
        proceedAlertButton(ofCase: .attemptToRemoveEquipment)
    }
    
    func testDismissKeyboard() {
        editSaveBtn.tap()
        // THEN
        availableTextField.tap()
        XCTAssert(app.keyboards.count > 0)
        availableTextField.typeSomeNumber()
        
        tapOutside(inVC: thisViewController)
        XCTAssertEqual(app.keyboards.count, 0)
        
        availableTextField.tap()
        XCTAssert(app.keyboards.count > 0)
        
        swipeView(inVC: thisViewController, toView: descriptionTextView)
        sleep(2)
        XCTAssertEqual(app.keyboards.count, 0)
        
        // Test name text field
        nameTextView.tap()
        XCTAssert(app.keyboards.count > 0)
        nameTextView.typeSomeText()
        
        tapOutside(inVC: thisViewController)
        XCTAssertEqual(app.keyboards.count, 0)
        
        nameTextView.tap()
        XCTAssert(app.keyboards.count > 0)
        
        swipeView(inVC: thisViewController, toView: descriptionTextView)
        XCTAssertEqual(app.keyboards.count, 0)
        
        nameTextView.tap()
        XCTAssert(app.keyboards.count > 0)
        nameTextView.typeSomeText()
        
        tapOutside(inVC: thisViewController)
        XCTAssertEqual(app.keyboards.count, 0)
        
        nameTextView.tap()
        XCTAssert(app.keyboards.count > 0)
        
        swipeView(inVC: thisViewController, toView: descriptionTextView)
        sleep(2)
        XCTAssertEqual(app.keyboards.count, 0)
        
        // location
        locationTextView.tap()
        XCTAssert(app.keyboards.count > 0)
        locationTextView.typeSomeText()
        
        tapOutside(inVC: thisViewController)
        XCTAssertEqual(app.keyboards.count, 0)
        
        locationTextView.tap()
        XCTAssert(app.keyboards.count > 0)
        
        swipeView(inVC: thisViewController, toView: descriptionTextView)
        sleep(2)
        XCTAssertEqual(app.keyboards.count, 0)
        
        // Test description text field
        descriptionTextView.tap()
        XCTAssert(app.keyboards.count > 0)
        descriptionTextView.typeText("la")
        
        tapOutside(inVC: thisViewController)
        XCTAssertEqual(app.keyboards.count, 0)
        
        descriptionTextView.tap()
        XCTAssert(app.keyboards.count > 0)
        
        swipeView(inVC: thisViewController, toView: descriptionTextView)
        XCTAssertEqual(app.keyboards.count, 0)
    }
    
    func testSucceedAlertShowed() {
        editSaveBtn.tap()
        
        let nameText = nameTextView.value as! String
        nameTextView.tap()
        nameTextView.deleteAllText()
        nameTextView.typeText(nameText)
        
        editSaveBtn.tap()
        sleep(2)
        // tap on alert button
        let alert = app.alerts[AlertCase.succeedToSaveEquipment.description]
        XCTAssertTrue(alert.exists)
        proceedAlertButton(ofCase: .succeedToSaveEquipment)
    }
}

