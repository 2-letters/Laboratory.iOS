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
    
    func testContainAView() {
        let bundle = Bundle(for: EquipmentInfoView.self)
        XCTAssertTrue(bundle.loadNibNamed(EquipmentInfoView.nibName, owner: nil)?.first is UIView)
//        guard let _ = bundle.loadNibNamed(EquipmentInfoView.nibName, owner: nil)?.first as? UIView else {
//            return XCTFail("CustomView nib did not contain a UIView")
//        }
    }

}
