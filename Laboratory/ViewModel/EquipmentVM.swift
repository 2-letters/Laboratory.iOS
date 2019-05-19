//
//  EquipmentVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

struct EquipmentVM {
    var equipmentName: String
    var quantity: Int
    var description: String
    var location: String
    var pictureUrl: String
    
    var accessoryType: UITableViewCell.AccessoryType
    
    init(equipment: Equipment) {
        equipmentName = equipment.name
        quantity = equipment.quantity
        description = equipment.description
        location = equipment.location
        pictureUrl = equipment.pictureUrl
        accessoryType = .disclosureIndicator
    }
}
