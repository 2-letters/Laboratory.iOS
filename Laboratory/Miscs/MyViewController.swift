//
//  MyViewController.swift
//  Laboratory
//
//  Created by Developers on 6/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

enum MyViewController: String {
    case LabList = "LabListVC"
    case LabInfo = "LabInfoVC"
    case LabEquipmentSelection = "LabEquipmentSelectionVC"
    var instance: UIViewController {
        return MyStoryboard.Main.instance.instantiateViewController(withIdentifier: self.rawValue)
    }
}
