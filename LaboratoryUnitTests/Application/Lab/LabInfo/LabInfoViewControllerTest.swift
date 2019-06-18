//
//  LabInfoViewControllerTest.swift
//  LaboratoryUnitTests
//
//  Created by Huy Vo on 6/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class MockTextField: UITextField {
    
}

class LabInfoViewControllerTest: XCTestCase {

    var sut: LabInfoVC!
    var labEquipmentSelectionVC: LabEquipmentSelectionVC!
    
    override func setUp() {
        super.setUp()
        sut = MyViewController.labInfo.instance as? LabInfoVC
        labEquipmentSelectionVC = MyViewController.labEquipmentSelection.instance as? LabEquipmentSelectionVC
        let _ = sut.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        labEquipmentSelectionVC = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        // GIVEN
        let navItem = sut.navigationItem
        let gestureRecognizers = sut.view.gestureRecognizers
        
        // THEN
        XCTAssertNotNil(navItem.rightBarButtonItem)
        XCTAssert(navItem.rightBarButtonItem?.target === sut)
        XCTAssertTrue(navItem.rightBarButtonItem?.action?.description == "saveBtnPressed")
        XCTAssertEqual(gestureRecognizers?.count, 1)
    }
    
    func testViewWillAppear() {
        // WHEN
        sut.isCreatingNewLab = true
        sut.beginAppearanceTransition(true, animated: true)
        // THEN
        XCTAssertEqual(sut.navigationItem.title, MyString.labCreateTitle)
        
        sut.endAppearanceTransition()
        
        
        // WHEN
        sut.isCreatingNewLab = false
        sut.beginAppearanceTransition(true, animated: true)
        
        // THEN
        XCTAssertEqual(sut.navigationItem.title, MyString.labEditTitle)
    }
    
    func testSegueInfos() {
        // GIVEN
        let identifiers = TestUtil.segues(ofViewController: sut)
        
        // WHEN
        UIApplication.shared.keyWindow?.rootViewController = sut
        sut.performSegue(withIdentifier: SegueId.presentEquipmentSelection, sender: nil)
        
        // THEN
        XCTAssertEqual(identifiers.count, 2)
        XCTAssertTrue(identifiers.contains(SegueId.presentEquipmentSelection))
        XCTAssertTrue(identifiers.contains(SegueId.unwindFromLabInfo))
        
        XCTAssert(sut.presentedViewController is UINavigationController)
        XCTAssert((sut.presentedViewController as! UINavigationController).viewControllers[0] is LabEquipmentSelectionVC)
    }
    
    func testPassingDataToEquipmentSelection() {
        // GIVEN
        sut.labId = FakeData.labId
        let navVC = UINavigationController(rootViewController: labEquipmentSelectionVC)
        let showLabEquipmentSelection = UIStoryboardSegue(identifier: SegueId.presentEquipmentSelection, source: sut, destination: navVC)
        
        // WHEN
        sut.prepare(for: showLabEquipmentSelection, sender: nil)
        
        // THEN
        XCTAssertEqual(labEquipmentSelectionVC.labId!, FakeData.labId)
    }
    
    func testSaveBtnPressed() {
        // GIVEN
        UIApplication.shared.keyWindow?.rootViewController = sut
        let saveBtn = sut.navigationItem.rightBarButtonItem
        
        // WHEN
        saveBtn?.target?.perform(saveBtn?.action)
        let ac = sut.presentedViewController as! UIAlertController
        
        // THEN
        XCTAssertNotNil(ac)
        XCTAssertEqual(ac.title, AlertString.oopsTitle)
        XCTAssertEqual(ac.message, AlertString.invalidLabInfoMessage)
        XCTAssertEqual(ac.actions.count, 1)
        XCTAssertEqual(ac.actions[0].title, AlertString.okay)
    }
    
    func testTableView() {
        // conformation
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        // selectors
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
    }
    
    func testTextFieldDelegate() {
        // GIVEN
        let mockTextField = MockTextField()
        
        // WHEN
        sut.textFieldDidBeginEditing(mockTextField)
        
        // THEN
        XCTAssertTrue(sut.conforms(to: UITextFieldDelegate.self))
    }
}
