//
//  SimpleEquipmentTVCell.swift
//  Laboratory
//
//  Created by Huy Vo on 5/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class SimpleEquipmentTVCell: UITableViewCell {
    static let reuseId = "SimpleEquipmentCell"
    
    @IBOutlet var equipmentNameLabel: UILabel!
    
    var viewModel: SimpleEquipmentVM? {
        didSet {
            equipmentNameLabel.text = viewModel?.equipmentName
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
