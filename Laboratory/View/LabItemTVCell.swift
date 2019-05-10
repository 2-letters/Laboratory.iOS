//
//  LabItemTVCell.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabItemTVCell: UITableViewCell {

    @IBOutlet var itemNameLbl: UILabel!
    @IBOutlet var quantityLbl: UILabel!
    
    var labItemVM: LabItemVM! {
        didSet {
            itemNameLbl.text = labItemVM.itemName
            accessoryType = labItemVM.accessoryType
        }
    }
    
    @IBAction func addQuantity(_ sender: UIButton) {
    }
    
    @IBAction func subtractQuantity(_ sender: UIButton) {
    }
}
