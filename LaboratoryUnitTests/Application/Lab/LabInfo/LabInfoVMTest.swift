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
        sut.fetchLabInfo(byId: FakeData.labId) { (<#FetchResult#>) in
            <#code#>
        }
    }
    
    func testSaveLab() {
        
    }
    
    func testRemoveLab() {
        
    }

}
