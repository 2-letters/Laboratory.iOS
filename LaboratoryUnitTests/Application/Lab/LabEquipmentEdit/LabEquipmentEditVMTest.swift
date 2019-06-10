//
//  LabEquipmentEditVMTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class LabEquipmentEditVMTest: XCTestCase {

    var sut: LabEquipmentEditVM!
    
    override func setUp() {
        super.setUp()
        let fakeEquipmentInfoVM = EquipmentInfoVM()
        fakeEquipmentInfoVM.equipment = FakeData.fullEquipment
        sut = LabEquipmentEditVM()
        sut.equipmentInfoVM = fakeEquipmentInfoVM
        sut.usingQuantity = 5
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testVariables() {
        // GIVEN
        sut.editingQuantity = 0
        
        // THEN
        XCTAssertEqual(sut.available, FakeData.fullEquipment.available)
        XCTAssertEqual(sut.isDecreaseBtnEnabled, false)
        XCTAssertEqual(sut.isIncreaseBtnEnabled, true)
        XCTAssertEqual(sut.isRemoveBtnEnabled, false)
        XCTAssertEqual(sut.isSaveBtnEnabled, true)
    }
    
    func testUpdateQuantityTextField() {
        // GIVEN
        let inputText = "1"
        sut.editingQuantity = 0
        
        // WHEN
        sut.updateQuantityTextField(withText: inputText)
        
        // THEN
        XCTAssertEqual(sut.editingQuantity, 1)
    }
}
