//
//  LabEquipmentEditVCTest.swift
//  LaboratoryUnitTests
//
//  Created by Huy Vo on 6/9/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class LabEquipmentEditVCTest: XCTestCase {

    var sut: LabEquipmentEditVC!
    var equipmentUserListVC: EquipmentUserListVC!
    private let showEquipmentUserListFromLabSegue = "showEquipmentUserListFromLab"
    private let unwindFromEquipmentEditSegue = "unwindFromEquipmentEdit"
    override func setUp() {
        super.setUp()
        sut = MyViewController.labEquipmentEdit.instance as? LabEquipmentEditVC
        equipmentUserListVC = MyViewController.equipmentUserList.instance as? EquipmentUserListVC
        let _ = sut.view
    }

    override func tearDown() {
        sut = nil
        equipmentUserListVC = nil
        super.tearDown()
    }

    func testViewDidLoad() {
        // GIVEN
        let gestureRecognizers = sut.view.gestureRecognizers
        
        // THEN
        XCTAssertEqual(gestureRecognizers?.count, 1)
        
        XCTAssertNotNil(sut.spinnerVC.view)
    }
    
    func testSegueInfo() {
        // GIVEN
        let identifiers = TestUtil.segues(ofViewController: sut)
        
        // THEN
        XCTAssertEqual(identifiers.count, 2)
        XCTAssertTrue(identifiers.contains(showEquipmentUserListFromLabSegue))
        XCTAssertTrue(identifiers.contains(unwindFromEquipmentEditSegue))
    }
    
    func testPassingDataToEquipmentUserList() {
        // GIVEN
        let showUserListSegue = UIStoryboardSegue(identifier: showEquipmentUserListFromLabSegue, source: sut, destination: equipmentUserListVC)
        
        // WHEN
        UserUtil.institutionId = FakeData.institutionId
        sut.prepare(for: showUserListSegue, sender: FakeData.equipmentId)
        
        // THEN
        XCTAssertEqual(equipmentUserListVC.equipmentId, FakeData.equipmentId)
    }
}
