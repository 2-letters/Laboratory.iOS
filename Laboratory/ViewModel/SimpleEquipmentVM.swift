//
//  LabEquipmentEditVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

struct SimpleEquipmentVM {
    var equipmentName: String
//    var selectionStyle: UITableViewCell.SelectionStyle
//    var accessoryType: UITableViewCell.AccessoryType
//    let isSelected: Observable<Bool>
    
    init(equipment: Equipment) {
        equipmentName = equipment.name
//        selectionStyle = .blue
//        accessoryType = .none
//
//        isSelected = Observable()
    }
}
