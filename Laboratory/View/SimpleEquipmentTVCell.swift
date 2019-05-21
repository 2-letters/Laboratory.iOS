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
    
//    var labItemEditVM: LabEquipmentEditVM?
//        didSet {
//            equipmentNameLabel.text = labItemSelectionVM?.equipmentName
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
    func setup(viewModel: SimpleEquipmentVM) {
//        labItemEditVM = viewModel
        equipmentNameLabel.text = viewModel.equipmentName
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
//            equipmentNameLabel.text = labItemSelectionVM.equipmentName
//            selectionStyle = labItemSelectionVM.selectionStyle
//            accessoryType = labItemSelectionVM.accessoryType
//        }
//    }
}
