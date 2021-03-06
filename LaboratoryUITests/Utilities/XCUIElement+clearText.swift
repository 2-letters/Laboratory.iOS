//
//  XCUIElement+clearText.swift
//  LaboratoryUITests
//
//  Created by Huy Vo on 6/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

extension XCUIElement {
    func typeSomeText(withLength length: Int = 1) {
        self.typeText(String(repeating: "a", count: length))
    }
    
    // TODO: is this really working?
    func typeSomeNumber(withLength length: Int = 1) {
        self.typeText(String(repeating: "5", count: length))
    }
    
//    func typeBigNumber() {
//        self.typeText(String(repeating: "5", count: 5))
//    }
    
    func deleteAllText() {
        guard let stringValue = self.value as? String else { return }
        // if the textfield is empty, value and placeholderValue are equal
        if let placeholderString = self.placeholderValue, placeholderString == stringValue {
            return
        }
        
        let lowerRightCorner = self.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.9))
        lowerRightCorner.tap()
        
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
