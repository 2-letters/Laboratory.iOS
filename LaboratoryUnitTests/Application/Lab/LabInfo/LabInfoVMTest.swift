//
//  LabInfoVMTest.swift
//  LaboratoryUnitTests
//
//  Created by Huy Vo on 6/21/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class LabInfoVMTest: XCTestCase {

    var sut: LabInfoVM!
    override func setUp() {
        super.setUp()
        sut = FakeData.labInfoVM
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchLabInfo() {
        // test success
        // GIVEN
        var isSuccessful = false
        var responseError: String?
        var promise = expectation(description: "Did fetch lab")
        
        // WHEN
        UserUtil.userId = FakeData.userId
        
        sut.fetchLabInfo(byId: FakeData.labId) { (fetchResult) in
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
        
        // test fail
        // GIVEN
        isSuccessful = false
        promise = expectation(description: "Did fetch lab")
        
        // THEN
        UserUtil.userId = FakeData.wrongUserId
        
        sut.fetchLabInfo(byId: FakeData.labId) { (fetchResult) in
            switch fetchResult {
            case let .failure(errorStr):
                responseError = errorStr
            case .success:
                isSuccessful = true
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        
        // WHEN
        XCTAssertNotNil(responseError)
        XCTAssertFalse(isSuccessful)
    }
    
    func testSaveLab() {
        // update existing lab
        // GIVEN
        var isSuccessful = false
        var responseError: String?
        var promise = expectation(description: "Did save lab")
        
        
        // WHEN
        UserUtil.userId = FakeData.userId
        
        sut.saveLab(withNewName: FakeData.newLabNameSave, newDescription: FakeData.newLabDescriptionSave, labId: FakeData.labId) { (updateResult) in
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
        
        // create new lab
        // GIVEN
        isSuccessful = false
        promise = expectation(description: "Did save lab")
        
        // WHEN
        sut.saveLab(withNewName: FakeData.newLabNameCreate, newDescription: FakeData.newLabDescriptionCreate, labId: nil) { (updateResult) in
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
