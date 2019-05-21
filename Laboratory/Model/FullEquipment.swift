//
//  FullEquipment.swift
//  Laboratory
//
//  Created by Developers on 5/21/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

class FullEquipment: Equipment {
    var quantity: Int
    var description: String
    var location: String
    var pictureUrl: String
    
    init(name: String, quantity: Int, description: String, location: String, pictureUrl: String) { 
        self.quantity = quantity
        self.description = description
        self.location = location
        self.pictureUrl = pictureUrl
        super.init(name: name)
    }
}
