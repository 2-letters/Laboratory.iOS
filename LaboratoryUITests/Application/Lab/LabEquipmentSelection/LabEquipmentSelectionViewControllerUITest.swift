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
    
    func testDismissKeyboard() {
        // test keyboard is shown
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
    
    
}
