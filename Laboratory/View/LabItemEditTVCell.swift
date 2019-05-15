//
//  LabItemSelectionTVCell.swift
//  Laboratory
//
//  Created by Huy Vo on 5/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabItemEditTVCell: UITableViewCell {

    @IBOutlet var itemNameLabel: UILabel!
    
    var labItemEditVM: LabItemEditVM?
//        didSet {
//            itemNameLabel.text = labItemSelectionVM?.itemName
//
//            // listen to the change of the isSelected property
//            // TODO: use subscribe of RxSwift instead
//            labItemSelectionVM?.isSelected.valueChanged = { [unowned self] (isSelected) in
//                if isSelected {
//                    self.accessoryType = .checkmark
//                } else {
//                    self.accessoryType = .none
//                }
//            }
//        }
//    }
    func setup(viewModel: LabItemEditVM) {
        labItemEditVM = viewModel
        itemNameLabel.text = viewModel.itemName
        accessoryType = .disclosureIndicator
        
        // listen to the change of the isSelected property
        // TODO: use subscribe of RxSwift instead
//        labItemSelectionVM?.isSelected.valueChanged = { [unowned self] (isSelected) in
//            if isSelected {
//                self.accessoryType = .checkmark
//            } else {
//                self.accessoryType = .none
//            }
//        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Unregister the observer to avoid the glitch when different view models update the same cell
//        labItemEditVM?.isSelected.valueChanged = nil
    }
    

    
//    var labItemSelectionVM: LabItemSelectionVM! {
//        didSet {
//            itemNameLabel.text = labItemSelectionVM.itemName
//            selectionStyle = labItemSelectionVM.selectionStyle
//            accessoryType = labItemSelectionVM.accessoryType
//        }
//    }
}
