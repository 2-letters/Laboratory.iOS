//
//  SimpleEquipmentTVCellTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class SimpleEquipmentTVCellTest: XCTestCase {

    var sut: SimpleEquipmentTVCell!
    private let cellNibName = "SimpleEquipmentTVCell"
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: SimpleEquipmentTVCell.self)
        let nib = bundle.loadNibNamed(cellNibName, owner: nil, options: nil)
        sut = nib?.first as? SimpleEquipmentTVCell
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testViewModelDidSet() {
        // GIVEN
        let fakeVM = FakeData.simpleEquipmentVM
        
        // WHEN
        sut.viewModel = fakeVM
        
        // THEN
        XCTAssertEqual(sut.equipmentNameLabel.text, fakeVM.equipmentName)
    }

}
