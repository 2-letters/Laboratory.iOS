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
        // Get main screen bounds
//        let screenSize: CGRect = UIScreen.main.bounds
//        let labCollectionCell = LabCollectionViewCell(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 110))
        
        let bundle = Bundle(for: LabCollectionViewCell.self)
        let nib = bundle.loadNibNamed(LabCollectionViewCell.nibId, owner: nil, options: nil)
        let labCollectionCell = nib?.first as! LabCollectionViewCell
        
        FBSnapshotVerifyView(labCollectionCell)
        FBSnapshotVerifyLayer(labCollectionCell.layer)
    }
}
