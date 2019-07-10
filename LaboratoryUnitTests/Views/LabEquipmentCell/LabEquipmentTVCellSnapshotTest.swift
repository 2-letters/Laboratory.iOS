//
//  LabEquipmentTVCellSnapshotTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/12/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import FBSnapshotTestCase
@testable import Laboratory

class LabEquipmentCellSnapshotTest: FBSnapshotTestCase {
    
    private let cellNibName = "LabEquipmentTVCell"
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func test() {
        let bundle = Bundle(for: LabEquipmentTVCell.self)
        let nib = bundle.loadNibNamed(cellNibName, owner: nil, options: nil)
        let labEquipmentCell = nib?.first as! LabEquipmentTVCell
        labEquipmentCell.viewModel = FakeData.labEquipmentVM
        
        FBSnapshotVerifyView(labEquipmentCell)
        FBSnapshotVerifyLayer(labEquipmentCell.layer)
    }
}
