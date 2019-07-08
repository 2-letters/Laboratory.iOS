//
//  SimpleEquipmentCellSnapshotTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import FBSnapshotTestCase
@testable import Laboratory

class SimpleEquipmentCellSnapshotTest: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func test() {
        let bundle = Bundle(for: SimpleEquipmentTVCell.self)
        let nib = bundle.loadNibNamed(NibName.a, owner: nil, options: nil)
        let simpleEquipmentCell = nib?.first as! SimpleEquipmentTVCell
        simpleEquipmentCell.viewModel = FakeData.simpleEquipmentVM
        
        FBSnapshotVerifyView(simpleEquipmentCell)
        FBSnapshotVerifyLayer(simpleEquipmentCell.layer)
    }

}
