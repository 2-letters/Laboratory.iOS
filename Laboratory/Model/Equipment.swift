//
//  Equipment.swift
//  Laboratory
//
//  Created by Huy Vo on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

protocol NamedItem {
    var name: String { get }
}
struct Equipment: NamedItem {
    var name: String
}
