//
//  EquipmentUserListVCSnapshotTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 7/1/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import FBSnapshotTestCase
@testable import Laboratory

class EquipmentUserListVCSnapshotTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func test() {
        let equipmentUserListVC = MyViewController.equipmentUserList.instance as! EquipmentUserListVC
        
        FBSnapshotVerifyView(equipmentUserListVC.view)
        FBSnapshotVerifyLayer(equipmentUserListVC.view.layer)
    }
}
