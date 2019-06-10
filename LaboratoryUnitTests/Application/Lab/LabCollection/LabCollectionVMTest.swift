//
//  LabCollectionVMTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class LabCollectionVMTest: XCTestCase {

    var sut: LabCollectionVM!
    override func setUp() {
        super.setUp()
        sut = LabCollectionVM()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGetLabId() {
        // GIVEN
        let fakeLabCellVMs = FakeData.LabCellVMs
        
        // WHEN
        sut.displayingLabVMs = FakeData.LabCellVMs
        
        // THEN
        for index in 0...(fakeLabCellVMs.count - 1) {
            XCTAssertEqual(sut.getLabId(at: index), fakeLabCellVMs[index].labId)
        }
    }
    
    func testSearch() {
        // GIVEN
        let searchText1 = ""
        
        // WHEN
        sut.allLabVMs = FakeData.LabCellVMs
        sut.displayingLabVMs = []
        sut.search(by: searchText1)
        
        // THEN
        XCTAssertEqual(sut.allLabVMs?.count, sut.displayingLabVMs?.count)
        
        // GIVEN
        let searchText2 = "fake"
        
        // WHEN
        sut.allLabVMs = FakeData.LabCellVMs
        sut.displayingLabVMs = []
        sut.search(by: searchText2)
        
        // THEN
        XCTAssertEqual(sut.displayingLabVMs?.count, 2)
        
        // GIVEN
        let searchText3 = "super"
        
        // WHEN
        sut.allLabVMs = FakeData.LabCellVMs
        sut.displayingLabVMs = []
        sut.search(by: searchText3)
        
        // THEN
        XCTAssertEqual(sut.displayingLabVMs?.count, 1)
    }
}
