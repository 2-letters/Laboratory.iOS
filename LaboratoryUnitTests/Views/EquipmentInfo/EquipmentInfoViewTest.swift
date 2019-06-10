//
//  EquipmentInfoViewTest.swift
//  LaboratoryUnitTests
//
//  Created by Huy Vo on 6/9/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class EquipmentInfoViewTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEquipmentInfoView() {    
        let frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        let areSubViewsEmpty = EquipmentInfoView(frame: frame).subviews.isEmpty
        XCTAssertTrue(areSubViewsEmpty)
        
        let sut = EquipmentInfoView.instantiate()
        sut.subviews.forEach { $0.removeFromSuperview() }
        
        XCTAssertEqual(sut.subviews, [],
                       "CustomView should have all subviews removed")
    }

}
