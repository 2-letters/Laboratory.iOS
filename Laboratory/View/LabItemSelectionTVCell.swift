//
//  LabItemSelectionTVCell.swift
//  Laboratory
//
//  Created by Huy Vo on 5/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabItemSelectionTVCell: UITableViewCell {

    @IBOutlet var itemNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    var labItemSelectionVM: LabItemSelectionVM! {
        didSet {
            itemNameLabel.text = labItemSelectionVM.itemName
            selectionStyle = labItemSelectionVM.selectionStyle
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
