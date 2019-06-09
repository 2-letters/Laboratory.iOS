//
//  LayoutUtilTest.swift
//  LaboratoryUnitTests
//
//  Created by Huy Vo on 6/9/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class MockTextView: UITextView {
    var didSizeToFit = false
    override func sizeToFit() {
        didSizeToFit = true
    }
}

class LayoutUtilTest: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testAdjustUITextViewHeight() {
        // GIVEN
        let mockTextView = MockTextView()
        
        // WHEN
        LayoutUtil.adjustUITextViewHeight(arg: mockTextView)
        
        // THEN
        XCTAssertTrue(mockTextView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(mockTextView.didSizeToFit)
        XCTAssertFalse(mockTextView.isScrollEnabled)
    }
}
