//
//  LabCollectionCellSnapshotTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/12/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import FBSnapshotTestCase
@testable import Laboratory

class LabCollectionCellSnapshotTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func test() {
        
        let bundle = Bundle(for: LabCollectionViewCell.self)
        let nib = bundle.loadNibNamed(LabCollectionViewCell.nibId, owner: nil, options: nil)
        let labCollectionCell = nib?.first as! LabCollectionViewCell
        labCollectionCell.viewModel = FakeData.labCellVM
        
        FBSnapshotVerifyView(labCollectionCell)
        FBSnapshotVerifyLayer(labCollectionCell.layer)
    }
}
