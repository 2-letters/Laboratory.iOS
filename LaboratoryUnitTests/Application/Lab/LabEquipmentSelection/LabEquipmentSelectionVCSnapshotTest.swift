//
//  LabEquipmentSelectionVCSnapshotTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/12/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import FBSnapshotTestCase
@testable import Laboratory

class LabEquipmentSelectionSnapshotTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func test() {
        let labEquipmentSelectionVC = MyViewController.LabEquipmentSelection.instance as! LabEquipmentSelectionVC
       labEquipmentSelectionVC.labId = FakeData.labId
        FBSnapshotVerifyView(labEquipmentSelectionVC.view)
        FBSnapshotVerifyLayer(labEquipmentSelectionVC.view.layer)
    }
}
