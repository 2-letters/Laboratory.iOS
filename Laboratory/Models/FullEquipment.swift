//
//  FullEquipment.swift
//  Laboratory
//
//  Created by Developers on 5/21/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

class FullEquipment {
    var name: String
    var available: Int
    var description: String
    var location: String
    var imageUrl: String
    
    init(name: String, available: Int, description: String, location: String, imageUrl: String) {
        self.name = name
        self.available = available
        self.description = description
        self.location = location
        self.imageUrl = imageUrl
    }
}
