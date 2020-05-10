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
        sut.editingQuantity.value = 0
        
        // THEN
        XCTAssertEqual(sut.equipmentName, FakeData.fullEquipment.name)
        XCTAssertEqual(sut.available, FakeData.fullEquipment.available)
        XCTAssertEqual(sut.isDecreaseBtnEnabled.value, false)
        XCTAssertEqual(sut.isIncreaseBtnEnabled.value, true)
        XCTAssertEqual(sut.isRemoveBtnEnabled.value, false)
        XCTAssertEqual(sut.isSaveBtnEnabled.value, true)
    }
    
    // TODO: implement
    func testUpdateEquipmentUsing() {
        // GIVEN
        let fakeLabId = FakeData.labId
        let fakeEquipmentId = FakeData.equipmentId
        var responseError: String?
        var didUpdateEquipmentUsing = false
        let promise = expectation(description: "Completion handler invoked")
        
        // WHEN
        sut.updateEquipmentUsing(forLabId: fakeLabId, equipmentId: fakeEquipmentId) { (updateResult) in
            switch updateResult {
            case let .failure(errorStr):
                responseError = errorStr
            case .success:
                didUpdateEquipmentUsing = true
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // THEN
        XCTAssertNil(responseError)
        XCTAssertTrue(didUpdateEquipmentUsing)
    }
    
    func testUpdateQuantityTextField() {
        // GIVEN
        let inputText = "1"
        sut.editingQuantity.value = 0
        
        // WHEN
        sut.updateQuantityTextField(withText: inputText)
        
        // THEN
        XCTAssertEqual(sut.editingQuantity.value, 1)
    }
}
