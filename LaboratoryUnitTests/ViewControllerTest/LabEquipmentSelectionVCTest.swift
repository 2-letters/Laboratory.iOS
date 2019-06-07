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
    override func setUp() {
        super.setUp()
        sut = MyViewController.LabEquipmentSelection.instance as? LabEquipmentSelectionVC
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
