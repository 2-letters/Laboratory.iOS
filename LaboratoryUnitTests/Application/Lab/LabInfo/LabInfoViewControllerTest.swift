//
//  LabInfoViewControllerTest.swift
//  LaboratoryUnitTests
//
//  Created by Huy Vo on 6/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class LabInfoViewControllerTest: XCTestCase {

    var sut: LabInfoViewController!
    var labEquipmentSelectionVC: LabEquipmentSelectionVC!
    private let presentEquipmentSelectionSegue = "presentEquipmentSelection"
    private let unwindFromLabInfoSegue = "unwindFromLabInfo"
    
    override func setUp() {
        super.setUp()
        sut = MyViewController.labInfo.instance as? LabInfoViewController
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
        let gestureRecognizers = sut.view.gestureRecognizers
        let saveBtn = sut.navigationItem.rightBarButtonItem
        
        // THEN
        XCTAssertNotNil(saveBtn)
        XCTAssertFalse(saveBtn!.isEnabled)
        XCTAssert(saveBtn?.target === sut)
        XCTAssertTrue(saveBtn?.action?.description == "saveButtonTapped")
        XCTAssertEqual(gestureRecognizers?.count, 1)
    }
    
    func testViewWillAppear() {
        // WHEN
        sut.isCreatingNewLab = true
        sut.beginAppearanceTransition(true, animated: true)
        // THEN
        XCTAssertEqual(sut.navigationItem.title, "Create a Lab")

        sut.endAppearanceTransition()
        
        
        // WHEN
        sut.isCreatingNewLab = false
        sut.beginAppearanceTransition(true, animated: true)
        
        // THEN
        XCTAssertEqual(sut.navigationItem.title, "Edit Lab")
    }
    
    func testDelegates() {
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.conforms(to: UITextViewDelegate.self))
    }
    
    func testSegueInfos() {
        // GIVEN
        let identifiers = TestUtil.segues(ofViewController: sut)
        
        // WHEN
        UIApplication.shared.keyWindow?.rootViewController = sut
        sut.performSegue(withIdentifier: presentEquipmentSelectionSegue, sender: nil)
        
        // THEN
        XCTAssertEqual(identifiers.count, 2)
        XCTAssertTrue(identifiers.contains(presentEquipmentSelectionSegue))
        XCTAssertTrue(identifiers.contains(unwindFromLabInfoSegue))
        
        XCTAssert(sut.presentedViewController is UINavigationController)
        XCTAssert((sut.presentedViewController as! UINavigationController).viewControllers[0] is LabEquipmentSelectionVC)
    }
    
    func testPassingDataToEquipmentSelection() {
        // GIVEN
        sut.labId = FakeData.labId
        let navVC = UINavigationController(rootViewController: labEquipmentSelectionVC)
        let presentLabEquipmentSelection = UIStoryboardSegue(identifier: presentEquipmentSelectionSegue, source: sut, destination: navVC)
        
        // WHEN
        sut.prepare(for: presentLabEquipmentSelection, sender: nil)
        
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
        XCTAssertEqual(ac.title, AlertString.oops)
        XCTAssertEqual(ac.message, AlertString.invalidLabInfoMessage)
        XCTAssertEqual(ac.actions.count, 1)
        XCTAssertEqual(ac.actions[0].title, AlertString.okay)
    }
    
    func testTableView() {
        // selectors
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
    }
}
