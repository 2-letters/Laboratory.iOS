//
//  LabEquipmentEditVCTest.swift
//  LaboratoryUnitTests
//
//  Created by Huy Vo on 6/9/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class LabEquipmentEditVCTest: XCTestCase {

    var sut: LabEquipmentEditVC!
    
    override func setUp() {
        super.setUp()
        sut = MyViewController.labEquipmentEdit.instance as? LabEquipmentEditVC
        let _ = sut.view
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testViewDidLoad() {
        // GIVEN
        let gestureRecognizers = sut.view.gestureRecognizers
        let tapGestureRecognizer = gestureRecognizers?.first
        
        // THEN
        XCTAssertEqual(gestureRecognizers?.count, 1)
        XCTAssertNotNil(tapGestureRecognizer)
        
        XCTAssertNotNil(sut.spinnerVC.view)
    }
}
