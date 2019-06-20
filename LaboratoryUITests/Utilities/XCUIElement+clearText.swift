//
//  XCUIElement+clearText.swift
//  LaboratoryUITests
//
//  Created by Huy Vo on 6/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

extension XCUIElement {
    func typeSomeText() {
        self.typeText("la")
    }
    
    // TODO: is this really working?
    func typeSomeNumber() {
        self.typeText("5")
    }
    
    func deleteAllText() {
        guard let stringValue = self.value as? String else { return }
        // if the textfield is empty, value and placeholderValue are equal
        if let placeholderString = self.placeholderValue, placeholderString == stringValue {
            return
        }
        
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
    }
    
    func clearText() {
        let canceBtn: XCUIElement?
        canceBtn = self.buttons["Clear text"]
        XCTAssertNotNil(canceBtn)
        canceBtn!.tap()
    }
}
