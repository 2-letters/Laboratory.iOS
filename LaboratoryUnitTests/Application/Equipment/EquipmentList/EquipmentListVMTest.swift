//
//  EquipmentListVMTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class EquipmentListVMTest: XCTestCase {

    var sut: EquipmentListVM!
    override func setUp() {
        super.setUp()
        sut = EquipmentListVM()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetName() {
        // GIVEN
        let fakeEquipmentVMs = FakeData.simpleEquipmentVMs
        
        // WHEN
        sut.displayingEquipmentVMs = fakeEquipmentVMs
        
        // THEN
        XCTAssertEqual(sut.getName(at: 2), fakeEquipmentVMs[2].equipmentName)
    }
    
    func testSearch() {
        // GIVEN
        let searchText1 = ""
        
        // WHEN
        sut.allEquipmentVMs = FakeData.simpleEquipmentVMs
        sut.displayingEquipmentVMs = []
        sut.search(by: searchText1)
        
        // THEN
        XCTAssertEqual(sut.allEquipmentVMs?.count, sut.displayingEquipmentVMs?.count)
        
        // GIVEN
        let searchText2 = "fake"
        
        // WHEN
        sut.allEquipmentVMs = FakeData.simpleEquipmentVMs
        sut.displayingEquipmentVMs = []
        sut.search(by: searchText2)
        
        // THEN
        XCTAssertEqual(sut.displayingEquipmentVMs?.count, 2)
        
        // GIVEN
        let searchText3 = "super"
        
        // WHEN
        sut.allEquipmentVMs = FakeData.simpleEquipmentVMs
        sut.displayingEquipmentVMs = []
        sut.search(by: searchText3)
        
        // THEN
        XCTAssertEqual(sut.displayingEquipmentVMs?.count, 1)
    }

}
