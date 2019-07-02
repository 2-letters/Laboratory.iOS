//
//  EquipmentInfoVCTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 7/1/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

class EquipmentInfoVCTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSegueInfo() {
        // GIVEN
        let identifiers = TestUtil.segues(ofViewController: sut)
        
        // THEN
        XCTAssertEqual(identifiers.count, 1)
        XCTAssertTrue(identifiers.contains(SegueId.showEquipmentUserListFromLab))
    }
    
    func testPassingDataToEquipmentUserList() {
        // GIVEN
        let showUserListSegue = UIStoryboardSegue(identifier: SegueId.showEquipmentUserListFromLab, source: sut, destination: equipmentUserListVC)
        
        // WHEN
        UserUtil.institutionId = FakeData.institutionId
        sut.prepare(for: showUserListSegue, sender: FakeData.equipmentId)
        
        // THEN
        XCTAssertEqual(equipmentUserListVC.equipmentId, FakeData.equipmentId)
    }

}
