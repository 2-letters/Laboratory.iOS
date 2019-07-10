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
        XCTAssertEqual(sut.equipmentName, fakeFullEquipment.name)
        XCTAssertEqual(sut.availableString, String(fakeFullEquipment.available))
        XCTAssertEqual(sut.description, fakeFullEquipment.description)
        XCTAssertEqual(sut.location, fakeFullEquipment.location)
        XCTAssertEqual(sut.imageUrl, fakeFullEquipment.imageUrl)
    }
    
    func testFetchEquipmentInfo() {
        // GIVEN
        var isSuccessful = false
        var responseError: String?
        var promise = expectation(description: "did fetch equipment info")
        
        // WHEN
        sut.fetchEquipmentInfo(byId: nil) { (fetchResult) in
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
        XCTAssertFalse(isSuccessful)
        XCTAssertNotNil(responseError)
        
        // GIVEN
        isSuccessful = false
        promise = expectation(description: "did fetch equipment info")
        
        // WHEN
        sut.fetchEquipmentInfo(byId: FakeData.equipmentId) { (fetchResult) in
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
        XCTAssertFalse(isSuccessful)
        XCTAssertNotNil(responseError)
    }
    
    func testSaveEquipment() {
        // update existing lab
        // GIVEN
        var isSuccessful = false
        var responseError: String?
        var promise = expectation(description: "Did save equipment")
        
        
        // WHEN
        UserUtil.institutionId = FakeData.institutionId
        
        sut.saveEquipment(withNewName: FakeData.equipmentName, newDescription: FakeData.equipmentDescription, newLocation: FakeData.equipmentLocation, newImageUrl: FakeData.equipmentImageUrl, newAvailable: FakeData.equipmentAvailable) { (updateResult) in
            switch updateResult {
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
        
        // create new equipment
        // GIVEN
        isSuccessful = false
        promise = expectation(description: "Did save lab")
        
        // WHEN
        sut.saveEquipment(withNewName: FakeData.equipmentNameCreate, newDescription: FakeData.equipmentDescriptionCreate, newLocation: FakeData.equipmentLocationCreate, newImageUrl: FakeData.equipmentImageUrlCreate, newAvailable: FakeData.equipmentAvailableCreate) { (updateResult) in
            switch updateResult {
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
    }
}
