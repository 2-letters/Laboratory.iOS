//
//  Item.swift
//  Laboratory
//
//  Created by Huy Vo on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

struct Item {
    var name: String
    var quantity: Int
    var description: String
    var location: String
    var pictureUrl: String
    
    init(name: String, quantity: Int, description: String, location: String, pictureUrl: String) {
        self.name = name
        self.quantity = quantity
        self.description = description
        self.location = location
        self.pictureUrl = pictureUrl
    }
    
    init(name: String) {
        self.name = name
        self.description = ""
        self.quantity = 0
        self.location = ""
        self.pictureUrl = ""
    }
}
