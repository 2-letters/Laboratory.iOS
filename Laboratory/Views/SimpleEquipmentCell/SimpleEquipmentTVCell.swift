//
//  SimpleEquipmentTVCell.swift
//  Laboratory
//
//  Created by Huy Vo on 5/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class SimpleEquipmentTVCell: UITableViewCell {
    static let nibId = "SimpleEquipmentTVCell"
    static let reuseId = "SimpleEquipmentCell"
    
    @IBOutlet var equipmentNameLabel: UILabel!
    
    var viewModel: SimpleEquipmentVM! {
        didSet {
            equipmentNameLabel.text = viewModel.equipmentName
            equipmentNameLabel.font = UIFont(name: secondaryFont, size: 18)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
