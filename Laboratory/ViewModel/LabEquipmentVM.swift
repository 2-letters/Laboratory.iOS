//
//  LabEquipmentVM.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

struct LabEquipmentVM {
    var equipmentName: String
    var quantity: Int
    var accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator
    
    init(_ equipment: LabEquipment) {
        self.equipmentName = equipment.name
        self.quantity = equipment.quantity
    }
}
