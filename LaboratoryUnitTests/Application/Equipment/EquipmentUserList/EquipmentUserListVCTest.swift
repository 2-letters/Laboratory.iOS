//
//  EquipmentUserListVCTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 7/1/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class EquipmentUserListVCTest: XCTestCase {

    var sut: EquipmentUserListVC!
    override func setUp() {
        super.setUp()
        sut = MyViewController.equipmentUserList.instance as? EquipmentUserListVC
        sut.equipmentId = FakeData.equipmentId
        let _ = sut.view
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testViewDidLoad() {
        // GIVEN
        let navItem = sut.navigationItem
        
        // THEN
        XCTAssertEqual(navItem.title, "List of users")
    }
    
    func testTableView() {
        // conformation
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        // selectors
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
    }
}
