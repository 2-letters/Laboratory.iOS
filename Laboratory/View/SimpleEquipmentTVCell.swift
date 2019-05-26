//
//  SimpleEquipmentTVCell.swift
//  Laboratory
//
//  Created by Huy Vo on 5/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class SimpleEquipmentTVCell: UITableViewCell {

    @IBOutlet var equipmentNameLabel: UILabel!
    
    func setup(viewModel: SimpleEquipmentVM?) {
        equipmentNameLabel.text = viewModel?.equipmentName
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
