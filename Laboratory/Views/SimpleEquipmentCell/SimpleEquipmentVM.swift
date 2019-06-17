//
//  LabEquipmentEditVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

// For SimpleEquipmentCell
struct SimpleEquipmentVM: Equatable {
    var equipment: Equipment
    
    var equipmentId: String {
        return equipment.id
    }
    
    var equipmentName: String {
        return equipment.name
    }
    
    init(equipment: Equipment) {
        self.equipment = equipment
    }
    
    static func ==(lhs: SimpleEquipmentVM, rhs: SimpleEquipmentVM) -> Bool {
        return lhs.equipmentName == rhs.equipmentName
    }
}
