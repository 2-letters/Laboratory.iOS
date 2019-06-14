//
//  MyViewController.swift
//  Laboratory
//
//  Created by Developers on 6/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

enum MyViewController: String {
    case labCollection = "LabCollectionVC"
    case labInfo = "LabInfoVC"
    case labEquipmentSelection = "LabEquipmentSelectionVC"
    case labEquipmentEdit = "LabEquipmentEditVC"
    case equipmentList = "EquipmentListVC"
    case equipmentInfo = "EquipmentInfoVC"
    var instance: UIViewController {
        return MyStoryboard.main.instance.instantiateViewController(withIdentifier: self.rawValue)
    }
}
