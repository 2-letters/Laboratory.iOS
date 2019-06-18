//
//  EquipmentListVCTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class EquipmentListVCTest: XCTestCase {

    var sut: EquipmentListVC!
    var equipmentInfoVC: EquipmentInfoVC!
    
    override func setUp() {
        super.setUp()
        sut = MyViewController.equipmentList.instance as? EquipmentListVC
        equipmentInfoVC = MyViewController.equipmentInfo.instance as? EquipmentInfoVC
        
        // Create the view
        let _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        equipmentInfoVC = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        // GIVEN
        let gestureRecognizers = sut.view.gestureRecognizers
        let navItem = sut.navigationItem
        
        // THEN
        XCTAssertEqual(gestureRecognizers?.count, 1)
        XCTAssertEqual(navItem.title, "Equipments")
        XCTAssertNotNil(navItem.rightBarButtonItem)
        XCTAssert(navItem.rightBarButtonItem?.target === sut)
        XCTAssertTrue(navItem.rightBarButtonItem?.action?.description == "createNewEquipment")
    }
    
    func testSegueInfo() {
        // GIVEN
        let identifiers = TestUtil.segues(ofViewController: sut)
        
        // THEN
        XCTAssertEqual(identifiers.count, 1)
        XCTAssertTrue(identifiers.contains(SegueId.showEquipmentInfo))
    }
    
    func testPassingDataToEquipmentEdit() {
        // GIVEN
        let fakeEquipmentId = FakeData.equipmentId
        let showEquipmentEditSegue = UIStoryboardSegue(identifier: SegueId.showEquipmentInfo, source: sut, destination: equipmentInfoVC)
        
        /// For not using equipments
        // WHEN
        sut.prepare(for: showEquipmentEditSegue, sender: fakeEquipmentId)
        
        // THEN
        XCTAssertEqual(equipmentInfoVC.equipmentId, fakeEquipmentId)
    }
    
    func testSearchBarDelegate() {
        XCTAssertTrue(sut.conforms(to: UISearchBarDelegate.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.searchBar(_:textDidChange:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.searchBarCancelButtonClicked(_:))))
    }
    
    func testTableView() {
        // conformation
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        // selectors
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:didSelectRowAt:))))
    }
    
    func testSearching() {
        // GIVEN
        let mockSearchBar = MockSearchBar()
        
        // WHEN
        sut.searchBarCancelButtonClicked(mockSearchBar)
        
        // THEN
        XCTAssertEqual(mockSearchBar.text, "")
    }
}
