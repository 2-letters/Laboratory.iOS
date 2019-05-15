//
//  Item.swift
//  Laboratory
//
//  Created by Huy Vo on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

class Item {
    var name: String
    var description: String
    var quantity: Int
    var location: String
    var pictureUrl: String
    
    init(name: String, description: String, quantity: Int, location: String, pictureUrl: String) {
        self.name = name
        self.description = description
        self.quantity = quantity
        self.location = location
        self.pictureUrl = pictureUrl
    }
    
    convenience init(name: String) {
        self.name = name
    }
}
