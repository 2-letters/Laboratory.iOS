//
//  EquipmentInfoView.swift
//  Laboratory
//
//  Created by Developers on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class EquipmentInfoView: UIView {
    
    @IBOutlet var availableTextField: UITextField!
    @IBOutlet var itemsLabel: UILabel!
    @IBOutlet var nameTextView: UITextView!
    @IBOutlet var locationTextView: UITextView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var equipmentImageView: UIImageView!
    @IBOutlet var addImageButton: UIButton!
    
    static func instantiate() -> EquipmentInfoView {
        let view: EquipmentInfoView = initFromNib()
        view.itemsLabel.font = UIFont(name: secondaryFont, size: 20)
        view.availableTextField.customize(isEditable: false)
        view.availableTextField.keyboardType = .numberPad
        view.availableTextField.textAlignment = .center
        view.nameTextView.customize(isEditable: false)
        view.locationTextView.customize(isEditable: false)
        view.descriptionTextView.customize(isEditable: false)
        
        view.addImageButton.backgroundColor = MyColor.lightGreen
        view.addImageButton.setTitleColor(UIColor.white, for: .normal)
        view.addImageButton.titleLabel?.font = UIFont(name: secondaryFont, size: 17)
        return view
    }
}
