//
//  LabEquipmentSelectionVMTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class LabEquipmentSelectionVMTest: XCTestCase {

    var sut: LabEquipmentSelectionVM!
    override func setUp() {
        super.setUp()
        sut = LabEquipmentSelectionVM()
        
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSearch1() {
        // GIVEN
        let searchText1 = ""
        
        // WHEN
        sut.allAddedEquipmentVMs = FakeData.labEquipmentVMs
        sut.allAvailableEquipmentVMs = FakeData.simpleEquipmentVMs
        sut.displayingAddedEquipmentVMs = []
        sut.displayingAvailableEquipmentVMs = []
//        sut.search(by: searchText1)
        
        // THEN
        XCTAssertEqual(sut.allAddedEquipmentVMs?.count, sut.displayingAddedEquipmentVMs?.count)
        XCTAssertEqual(sut.allAvailableEquipmentVMs?.count, sut.displayingAvailableEquipmentVMs?.count)
    }
    
    func  testSearch2() {
        // GIVEN
        let searchText2 = "fake"
        
        // WHEN
        sut.allAddedEquipmentVMs = FakeData.labEquipmentVMs
        sut.allAvailableEquipmentVMs = FakeData.simpleEquipmentVMs
        sut.displayingAddedEquipmentVMs = []
        sut.displayingAvailableEquipmentVMs = []
//        sut.search(by: searchText2)
        
        // THEN
        XCTAssertEqual(sut.displayingAddedEquipmentVMs?.count, 2)
        XCTAssertEqual(sut.displayingAvailableEquipmentVMs?.count, 2)
    }
    
    func testSearch3() {
        // GIVEN
        let searchText3 = "super"
        
        // WHEN
        sut.allAddedEquipmentVMs = FakeData.labEquipmentVMs
        sut.allAvailableEquipmentVMs = FakeData.simpleEquipmentVMs
        sut.displayingAddedEquipmentVMs = []
        sut.displayingAvailableEquipmentVMs = []
//        sut.search(by: searchText3)
        
        // THEN
        XCTAssertEqual(sut.displayingAddedEquipmentVMs?.count, 1)
        XCTAssertEqual(sut.displayingAvailableEquipmentVMs?.count, 1)
    }
}
