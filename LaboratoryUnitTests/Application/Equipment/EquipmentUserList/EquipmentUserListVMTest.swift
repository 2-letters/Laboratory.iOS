//
//  EquipmentUserListVMTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 7/1/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class EquipmentUserListVMTest: XCTestCase {

    var sut: EquipmentUserListVM!
    override func setUp() {
        super.setUp()
        sut = EquipmentUserListVM()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetters() {
        // GIVEN
        sut.equipmentUserVMs = FakeData.equipmentUserVMs
        let equipmentUserVM1: EquipmentUserVM = sut.equipmentUserVMs!.first!
        
        // THEN
        XCTAssertEqual(equipmentUserVM1.userName, FakeData.userName1)
        XCTAssertEqual(equipmentUserVM1.usingString, "Using: \(FakeData.using1)")
    }
    
    func testGetUsers() {
        // GIVEN
        var isSuccessful = false
        var responseError: String?
        var promise = expectation(description: "successfuly fetch equipment users")
        
        // WHEN
        UserUtil.institutionId = FakeData.institutionId
        sut.getUsers(forEquipmentId: FakeData.equipmentId) { (fetchResult) in
            switch fetchResult {
            case let .failure(errorStr):
                responseError = errorStr
            case .success:
                isSuccessful = true
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // THEN
        XCTAssertNil(responseError)
        XCTAssertTrue(isSuccessful)
        
        // GIVEN
        isSuccessful = false
        responseError = nil
        promise = expectation(description: "successfuly fetch equipment users")
        
        // WHEN
        sut.getUsers(forEquipmentId: FakeData.wrongEquipmentId) { (fetchResult) in
            switch fetchResult {
            case let .failure(errorStr):
                responseError = errorStr
            case .success:
                isSuccessful = true
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // THEN
        // TODO: both fail
        XCTAssertNotNil(responseError)
        XCTAssertFalse(isSuccessful)
    }
}
