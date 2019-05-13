//
//  LabItemVM.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

struct LabItemVM {
    var itemName: String
    var quantity: Int
    var accessoryType: UITableViewCell.AccessoryType
    
    init(_ item: LabItem) {
        self.itemName = item.itemName
        self.quantity = item.quantity
        accessoryType = .disclosureIndicator
    }
}
