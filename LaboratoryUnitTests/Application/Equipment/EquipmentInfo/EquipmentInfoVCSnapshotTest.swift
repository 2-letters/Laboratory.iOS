//
//  EquipmentInfoVCSnapshotTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/12/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import FBSnapshotTestCase
@testable import Laboratory

class EquipmentInfoVCSnapshotTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = true
    }
    
    func test() {
        let equipmentInfoVC = MyViewController.equipmentInfo.instance as! EquipmentInfoVC
        
        equipmentInfoVC.equipmentId = FakeData.equipmentId
        
        FBSnapshotVerifyView(equipmentInfoVC.view)
        FBSnapshotVerifyLayer(equipmentInfoVC.view.layer)
    }
}
