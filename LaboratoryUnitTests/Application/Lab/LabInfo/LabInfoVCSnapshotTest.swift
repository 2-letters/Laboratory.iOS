//
//  LabInfoVCSnapshotTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/12/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import FBSnapshotTestCase
@testable import Laboratory

class LabInfoVCSnapshotTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func test() {
        let labInfoVC = MyViewController.labInfo.instance as! LabInfoVC
        labInfoVC.labId = FakeData.labId
        
        FBSnapshotVerifyView(labInfoVC.view)
        FBSnapshotVerifyLayer(labInfoVC.view.layer)
    }
}
