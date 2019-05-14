//
//  LabItemSelectionVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

struct LabItemSelectionVM {
    var itemName: String
//    var selectionStyle: UITableViewCell.SelectionStyle
//    var accessoryType: UITableViewCell.AccessoryType
    let isSelected: Observable<Bool>
    
    init(_ item: LabItem) {
        itemName = item.itemName
//        selectionStyle = .blue
//        accessoryType = .none
//
        isSelected = Observable()
    }
}
