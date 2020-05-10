//
//  LabEquipmentTVCellTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class LabEquipmentTVCellTest: XCTestCase {

    var sut: LabEquipmentTVCell!
    private let cellNibName = "LabEquipmentTVCell"
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: LabEquipmentTVCell.self)
        let nib = bundle.loadNibNamed(cellNibName, owner: nil, options: nil)
        sut = nib?.first as? LabEquipmentTVCell
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testViewModelDidSet() {
        // GIVEN
        let fakeVM = FakeData.labEquipmentVM
        
        // WHEN
        sut.viewModel = fakeVM
        
        // THEN
        XCTAssertEqual(sut.equipmentNameLabel.text, fakeVM.equipmentName)
        XCTAssertEqual(sut.quantityLabel.text, fakeVM.quantityString)
    }

}
