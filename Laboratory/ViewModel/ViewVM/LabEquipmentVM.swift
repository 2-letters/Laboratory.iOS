//
//  LabEquipmentVM.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

struct LabEquipmentVM {
    let labEquipment: LabEquipment
    
    init(equipment: LabEquipment) {
        self.labEquipment = equipment
    }
    
    var equipmentName: String { return labEquipment.name }
    var quantityString: String {
        return "Using: \(labEquipment.quantity)"
    }
    var quantity: Int {
        return labEquipment.quantity
    }
}
