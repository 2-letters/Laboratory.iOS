//
//  EquipmentInfoVMTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class EquipmentInfoVMTest: XCTestCase {

    var sut: EquipmentInfoVM!
    override func setUp() {
        super.setUp()
        sut = EquipmentInfoVM()
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testVariables() {
        // GIVEN
        let fakeFullEquipment = FakeData.fullEquipment
        
        // WHEN
        sut.equipment = fakeFullEquipment
        
        // THEN
        XCTAssertEqual(sut.equipmentName, "Name:  \(fakeFullEquipment.name)")
        XCTAssertEqual(sut.availableString, "Available:  \(fakeFullEquipment.available) (items)")
        XCTAssertEqual(sut.description, fakeFullEquipment.description)
        XCTAssertEqual(sut.location, fakeFullEquipment.location)
        XCTAssertEqual(sut.pictureUrl, fakeFullEquipment.pictureUrl)
    }
}
