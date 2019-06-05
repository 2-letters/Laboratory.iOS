//
//  LabInfo.swift
//  Laboratory
//
//  Created by Developers on 5/21/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

struct LabInfo {
    var name: String
    var description: String
    var equipments: [LabEquipment] = [LabEquipment]()
    
    init(name: String, description: String = "", equipments: [LabEquipment] = [LabEquipment]()) {
        self.name = name
        self.description = description
        self.equipments = equipments
//        name = dictionary["labName"] as? String ?? ""
//        description = dictionary["description"] as? String ?? ""
//
//        for (key, value) in dictionary["equipments"] as! [String: Any] {
//            equipments.append(LabEquipment(name: key, using: Int(value as! String)!))
//        }
    }
    
//    init(name: String) {
//        self.name = name
//    }
}
