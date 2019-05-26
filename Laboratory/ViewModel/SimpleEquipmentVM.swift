//
//  LabEquipmentEditVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

struct SimpleEquipmentVM: Equatable {
    var equipmentName: String
    
    init(equipment: Equipment) {
        equipmentName = equipment.name
    }
    
    static func ==(lhs: SimpleEquipmentVM, rhs: SimpleEquipmentVM) -> Bool {
        return lhs.equipmentName == rhs.equipmentName
    }
}
