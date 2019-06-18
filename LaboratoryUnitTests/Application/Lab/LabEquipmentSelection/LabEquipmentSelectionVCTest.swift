//
//  LabEquipmentSelectionVCTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class LabEquipmentSelectionVCTest: XCTestCase {

    var sut: LabEquipmentSelectionVC!
    var labEquipmentEditVC: LabEquipmentEditVC!
    
    override func setUp() {
        super.setUp()
        sut = MyViewController.labEquipmentSelection.instance as? LabEquipmentSelectionVC
        labEquipmentEditVC = MyViewController.labEquipmentEdit.instance as? LabEquipmentEditVC
        let _ = sut.view
    }

    override func tearDown() {
        sut = nil
        labEquipmentEditVC = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        // GIVEN
        let gestureRecognizers = sut.view.gestureRecognizers
        
        // THEN
        XCTAssertEqual(gestureRecognizers?.count, 1)
        XCTAssertEqual(sut.navigationItem.title, MyString.labEquipmentCollectionTitle)
        XCTAssertNotNil(sut.spinnerVC.view)
    }
    
    func testSegueInfo() {
        // GIVEN
        let identifiers = TestUtil.segues(ofViewController: sut)
        
        // THEN
        XCTAssertEqual(identifiers.count, 2)
        XCTAssertTrue(identifiers.contains(SegueId.showEquipmentEdit))
        XCTAssertTrue(identifiers.contains(SegueId.unwindFromEquipmentSelection))
    }
    
    func testPassingDataToEquipmentEdit() {
        // GIVEN
        sut.labId = FakeData.labId
        let showEquipmentEditSegue = UIStoryboardSegue(identifier: SegueId.showEquipmentEdit, source: sut, destination: labEquipmentEditVC)
        let fakeSimpleEquipmentVM = FakeData.simpleEquipmentVM
        let fakeLabEquipmentVM = FakeData.labEquipmentVM
        
        /// For not using equipments
        // WHEN
        sut.prepare(for: showEquipmentEditSegue, sender: fakeSimpleEquipmentVM)
        
        // THEN
        XCTAssertEqual(labEquipmentEditVC.labId, FakeData.labId)
        XCTAssertEqual(labEquipmentEditVC.equipmentId, fakeSimpleEquipmentVM.equipmentId)
        XCTAssertEqual(labEquipmentEditVC.usingQuantity, 0)
        
        /// For currently using equipments
        // WHEN
        sut.prepare(for: showEquipmentEditSegue, sender: fakeLabEquipmentVM)
        
        // THEN
        XCTAssertEqual(labEquipmentEditVC.labId, FakeData.labId)
        XCTAssertEqual(labEquipmentEditVC.equipmentId, fakeLabEquipmentVM.equipmentId)
        XCTAssertEqual(labEquipmentEditVC.usingQuantity, fakeLabEquipmentVM.quantity)
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
        XCTAssertTrue(sut.responds(to: #selector(sut.numberOfSections(in:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:titleForHeaderInSection:))))
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
