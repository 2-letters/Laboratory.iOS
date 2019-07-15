//
//  LabInfo.swift
//  Laboratory
//
//  Created by Developers on 5/21/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

class LabInfo {
    var name: String
    var description: String = ""
    var equipments: [LabEquipment] = [LabEquipment]()
    
    init(name: String, description: String, equipments: [LabEquipment]) {
        self.name = name
        self.description = description
        self.equipments = equipments
    }
}
