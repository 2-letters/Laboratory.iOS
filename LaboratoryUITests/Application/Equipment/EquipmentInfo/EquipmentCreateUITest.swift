//
//  EquipmentCreateUITest.swift
//  LaboratoryUITests
//
//  Created by Developers on 7/3/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

class EquipmentCreateUITest: MyUITestDelegate {

    var app: XCUIApplication!
    var thisViewController: MyViewController!
    var saveBtn: XCUIElement!
    var availableTextField: XCUIElement!
    var nameTextView: XCUIElement!
    var locationTextView: XCUIElement!
    var descriptionTextView: XCUIElement!
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        thisViewController = .equipmentInfo
        goToEquipmentCreate()
        
        saveBtn = app.buttons[AccessibilityId.equipmentInfoEditSaveButton.description]
        availableTextField = app.textFields[AccessibilityId.equipmentInfoAvailableTextField.description]
        nameTextView = app.textViews[AccessibilityId.equipmentInfoNameTextView.description]
        locationTextView = app.textViews[AccessibilityId.equipmentInfoLocationTextView.description]
        descriptionTextView = app.textViews[AccessibilityId.equipmentInfoDescriptionTextView.description]
    }
    
    override func tearDown() {
        app = nil
        saveBtn = nil
        availableTextField = nil
        nameTextView = nil
        locationTextView = nil
        descriptionTextView = nil
        
        super.tearDown()
    }
    
    func testViewsExist() {
        let imageView = app.images[AccessibilityId.equipmentInfoImageView.description]
        let addImageButton = app.buttons[AccessibilityId.equipmentInfoAddImageButton.description]
        let removeEquipmentButton = app.buttons[AccessibilityId.equipmentInfoRemoveEquipmentButton.description]
        let listOfUserButton = app.buttons[AccessibilityId.equipmentInfoListOfUserButton.description]
        
        XCTAssertTrue(saveBtn.exists)
        XCTAssertTrue(availableTextField.exists)
        XCTAssertTrue(nameTextView.exists)
        XCTAssertTrue(locationTextView.exists)
        XCTAssertTrue(descriptionTextView.exists)
        // TODO: this fail
        XCTAssertTrue(imageView.exists)
        XCTAssertTrue(addImageButton.exists)
        XCTAssertTrue(addImageButton.isHittable)
        XCTAssertFalse(removeEquipmentButton.exists)
        XCTAssertFalse(listOfUserButton.exists)
    }
    
    func testEmptyQuantityBecomeZero() {
        saveBtn.tap()
        
        availableTextField.tap()
        availableTextField.deleteAllText()
        tapOutside(inVC: thisViewController)
        
        XCTAssertEqual(availableTextField.value as! String, "0")
    }
    
    func testTextViewAndTextFieldShouldChangeText() {
        saveBtn.tap()
        
        // WHEN
        availableTextField.tap()
        availableTextField.deleteAllText()
        availableTextField.typeSomeNumber(withLength: MyInt.nameTextLimit + 1)
        
        // THEN
        let availableText = nameTextView.value as! String
        // TODO: this fail XCTAssertEqual failed: ("0") is not equal to ("5")
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
        saveBtn.tap()
        
        // clear all inputs
        nameTextView.tap()
        nameTextView.deleteAllText()
        descriptionTextView.tap()
        descriptionTextView.deleteAllText()
        
        saveBtn.tap()
        sleep(2)
        
        //        let alert = app.alerts[AlertCase.invalidLabInfoInput.description]
        //        XCTAssertTrue(alert.exists)
        // close the alert
        proceedAlertButton(ofCase: .invalidEquipmentInfoInput)
    }
    
    func testSaveButtonTapped() {
        let equipmentName = "Unit Test Equipment Name 1"
        let equipmentLocation = "Delete me when you have time"
        let equipmentDescription = "Please delete meeeeeee. Dont even ask"
        
        availableTextField.tap()
        availableTextField.typeSomeText(withLength: 3)
        
        nameTextView.tap()
        nameTextView.typeText(equipmentName)
        
        locationTextView.tap()
        locationTextView.typeText(equipmentLocation)
        
        descriptionTextView.tap()
        descriptionTextView.typeText(equipmentDescription)
        
        let addImageButton = app.buttons[AccessibilityId.equipmentInfoAddImageButton.description]
        addImageButton.tap()
        
        // tap on "Camera Roll"
        // TODO: this fail No matches found for Find: Descendants matching type Table from input {(
        app.tables.cells.element(boundBy: 0).tap()
        sleep(2)
        // tap on the first picture
        app.collectionViews.element(boundBy: 0).cells.element(boundBy: 0).tap()
        sleep(2)
        //  Choose Button
        let chooseButton = app.buttons.element(boundBy: 1)
        chooseButton.tap()
        sleep(2)
        
        saveBtn.tap()
    }
}
