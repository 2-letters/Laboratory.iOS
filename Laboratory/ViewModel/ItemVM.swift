//
//  ItemVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

struct ItemVM {
    var itemName: String
    var accessoryType: UITableViewCell.AccessoryType
    
    init(item: Item) {
        itemName = item.name
        accessoryType = .disclosureIndicator
    }
}
