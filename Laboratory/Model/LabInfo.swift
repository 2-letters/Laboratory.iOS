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
    var equipments: [LabEquipment]
    

    init(dictionary: [String: Any]) {
        name = dictionary["labName"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        
        var labEquipments = [LabEquipment]()
        for (key, value) in dictionary["equipments"] as! [String: Any] {
            labEquipments.append(LabEquipment(name: key, quantity: value as? Int ?? 0))
        }
        
        equipments = labEquipments
    }
}
