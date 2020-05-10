//
//  EquipmentListVCSnapshotTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/12/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import FBSnapshotTestCase
@testable import Laboratory

class EquipmentListVCSnapshotTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = true
    }
    
    func test() {
        let equipmentListVC = MyViewController.equipmentList.instance as! EquipmentListVC
        
        FBSnapshotVerifyView(equipmentListVC.view)
        FBSnapshotVerifyLayer(equipmentListVC.view.layer)
    }
}
