//
//  LabEquipmentTVCell.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabEquipmentTVCell: UITableViewCell {
//    static let nibId = "LabEquipmentTVCell"
//    static let reuseId =  "LabEquipmentCell"
    
    @IBOutlet var equipmentNameLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    
    var viewModel: LabEquipmentVM! {
        didSet {
            equipmentNameLabel.text = viewModel.equipmentName
            quantityLabel.text = viewModel.quantityString
            equipmentNameLabel.font = UIFont(name: "GillSans", size: 18)
            quantityLabel.font = UIFont(name: "GillSans", size: 18)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
