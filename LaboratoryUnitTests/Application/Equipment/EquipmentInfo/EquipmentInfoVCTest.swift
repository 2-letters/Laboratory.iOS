//
//  EquipmentInfoVCTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 7/1/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class EquipmentInfoVCTest: XCTestCase {

    var sut: EquipmentInfoVC!
    var equipmentUserListVC: EquipmentUserListVC!
    private let showEquipmentUserListFromEquipmentSegue = "showEquipmentUserListFromEquipment"
    private let unwindFromEquipmentInfoSegue = "unwindFromEquipmentInfo"
    override func setUp() {
        super.setUp()
        sut = MyViewController.equipmentInfo.instance as? EquipmentInfoVC
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
        let editSaveButton = sut.navigationItem.rightBarButtonItem
        
        // THEN
        XCTAssertNotNil(editSaveButton)
        XCTAssertTrue(editSaveButton!.isEnabled)
        XCTAssert(editSaveButton?.target === sut)
        XCTAssertTrue(editSaveButton?.action?.description == "editSubmitButtonTapped")
        XCTAssertEqual(gestureRecognizers?.count, 1)
    }

    func testSegueInfo() {
        // GIVEN
        let identifiers = TestUtil.segues(ofViewController: sut)
        
        // THEN
        XCTAssertEqual(identifiers.count, 2)
        XCTAssertTrue(identifiers.contains(showEquipmentUserListFromEquipmentSegue))
        XCTAssertTrue(identifiers.contains(unwindFromEquipmentInfoSegue))
    }
    
    func testPassingDataToEquipmentUserList() {
        // GIVEN
        let showUserListSegue = UIStoryboardSegue(identifier: showEquipmentUserListFromEquipmentSegue, source: sut, destination: equipmentUserListVC)
        
        // WHEN
        UserUtil.institutionId = FakeData.institutionId
        sut.prepare(for: showUserListSegue, sender: FakeData.equipmentId)
        
        // THEN
        XCTAssertEqual(equipmentUserListVC.equipmentId, FakeData.equipmentId)
    }
    
    func testDelegates() {
        XCTAssertTrue(sut.conforms(to: UIScrollViewDelegate.self))
        XCTAssertTrue(sut.conforms(to: UITextFieldDelegate.self))
        XCTAssertTrue(sut.conforms(to: UITextViewDelegate.self))
//        XCTAssertTrue(sut.conforms(to: SpinnerPresentable.self))
//        XCTAssertTrue(sut.conforms(to: AlertPresentable.self))
//        XCTAssertTrue(sut.conforms(to: ImagePickable.self))
    }
}
