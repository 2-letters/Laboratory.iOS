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
    
    var labEquipmentVM: LabEquipmentVM! {
        didSet {
            equipmentNameLbl.text = labEquipmentVM.equipmentName
            accessoryType = labEquipmentVM.accessoryType
        }
    }
    
    @IBAction func addQuantity(_ sender: UIButton) {
    }
    
    @IBAction func subtractQuantity(_ sender: UIButton) {
    }
}
