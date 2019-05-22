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
    var description: String = ""
    var equipments: [LabEquipment] = [LabEquipment]()
    
    init(dictionary: [String: Any]) {
        name = dictionary["labName"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        
        for (key, value) in dictionary["equipments"] as! [String: Any] {
            print("vox key: \(key) value: \(value)")
            equipments.append(LabEquipment(name: key, quantity: Int(value as! String)!))
        }
    }
    
    init(name: String) {
        self.name = name
    }
}
