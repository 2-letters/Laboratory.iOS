//
//  LabEquipmentEditVCSnapshotTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/12/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import FBSnapshotTestCase
@testable import Laboratory

class LabEquipmentEditVCSnapshotTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func test() {
        let labEquipmentEditVC = MyViewController.LabEquipmentEdit.instance as! LabEquipmentEditVC
        labEquipmentEditVC.labId = FakeData.labId
        labEquipmentEditVC.equipmentName = FakeData.equipmentName
        
        FBSnapshotVerifyView(labEquipmentEditVC.view)
        FBSnapshotVerifyLayer(labEquipmentEditVC.view.layer)
    }
}
