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

    var sut: LabInfoViewModel!
    override func setUp() {
        super.setUp()
        sut = FakeData.labInfoVM
        sut.labInfo = FakeData.labInfo
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
        sut.labId = FakeData.labId
        sut.fetchLabInfo() { (fetchResult) in
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
        sut.labId = FakeData.labId
        sut.fetchLabInfo() { (fetchResult) in
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
        sut.labId = FakeData.labId
        sut.labName = FakeData.newLabNameSave
        sut.description = FakeData.newLabDescriptionSave
        sut.saveLab() { (updateResult) in
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
        sut.labId = nil
        sut.labName = FakeData.newLabNameCreate
        sut.description = FakeData.newLabDescriptionCreate
        
        // WHEN
        sut.saveLab() { (updateResult) in
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
