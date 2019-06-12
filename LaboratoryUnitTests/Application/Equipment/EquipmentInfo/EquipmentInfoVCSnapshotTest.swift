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
        recordMode = false
    }
    
    func test() {
        let equipmentInfoVC = MyViewController.EquipmentInfo.instance as! EquipmentInfoVC
        // TODO change this to id
        equipmentInfoVC.equipmentName = FakeData.equipmentName
        
        FBSnapshotVerifyView(equipmentInfoVC.view)
        FBSnapshotVerifyLayer(equipmentInfoVC.view.layer)
    }
}
