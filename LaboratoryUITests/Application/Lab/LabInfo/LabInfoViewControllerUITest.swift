//
//  LabInfoViewControllerUITest.swift
//  LaboratoryUITests
//
//  Created by Developers on 6/14/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

class LabInfoViewControllerUITest: MyUITest {

    var app: XCUIApplication!
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        goToFirstTab()
        tapFirstCell(inVC: .labCollection)
    }
    
    
}
