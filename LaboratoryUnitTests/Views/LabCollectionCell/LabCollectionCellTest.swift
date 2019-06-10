//
//  LabCollectionCellTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/10/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class LabCollectionCellTest: XCTestCase {

    var sut: LabCollectionViewCell!
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: LabCollectionViewCell.self)
        let nib = bundle.loadNibNamed(LabCollectionViewCell.nibId, owner: nil, options: nil)
        sut = nib?.first as? LabCollectionViewCell
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testViewModelDidSet() {
        // GIVEN
        let fakeVM = FakeData.labCellVM
        
        // WHEN
        sut.viewModel = fakeVM
        
        // THEN
        XCTAssertEqual(sut.labNameLabel.text, fakeVM.labName)
        XCTAssertEqual(sut.labDescriptionLabel.text, fakeVM.description)
        XCTAssertEqual(sut.layer.shadowOffset, CGSize(width: 0, height: 0.5))
        XCTAssertEqual(sut.layer.shadowColor, UIColor.lightGray.cgColor)
        XCTAssertEqual(sut.layer.shadowRadius, 2)
        XCTAssertEqual(sut.layer.shadowOpacity, 0.25)
        XCTAssertFalse(sut.clipsToBounds)
        XCTAssertFalse(sut.layer.masksToBounds)
    }
}
