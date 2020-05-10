//
//  LabCollectionVCSnapshotTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/12/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import FBSnapshotTestCase
@testable import Laboratory

class LabCollectionVCSnapshotTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = true
    }
    
    func test() {
        let labCollectionVC = MyViewController.labCollection.instance as! LabCollectionVC
        
        FBSnapshotVerifyView(labCollectionVC.view)
        FBSnapshotVerifyLayer(labCollectionVC.view.layer)
    }
}
