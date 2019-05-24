//
//  LabEquipmentTVCell.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabEquipmentTVCell: UITableViewCell {

    @IBOutlet var equipmentNameLbl: UILabel!
    @IBOutlet var quantityLbl: UILabel!
    
//    var labEquipmentVM: LabEquipmentVM! {
//        didSet {
//            equipmentNameLbl.text = labEquipmentVM.equipmentName
//            accessoryType = labEquipmentVM.accessoryType
//        }
//    }
    
    func setup(viewModel: LabEquipmentVM?) {
        equipmentNameLbl.text = viewModel?.equipmentName
        quantityLbl.text = viewModel?.quantityString
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
