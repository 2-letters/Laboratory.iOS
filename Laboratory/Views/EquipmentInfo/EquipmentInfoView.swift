//
//  EquipmentInfoView.swift
//  Laboratory
//
//  Created by Developers on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

enum EquipmentInfoViewCase {
    case equipmentInfo
    case equipmentInfoLabEdit
    case equipmentCreate
}

class EquipmentInfoView: UIView {
    
    @IBOutlet var availableTextField: MyTextField!
    @IBOutlet var itemsLabel: UILabel!
    @IBOutlet var nameTextView: MyTextView!
    @IBOutlet var locationTextView: MyTextView!
    @IBOutlet var descriptionTextView: MyTextView!
    @IBOutlet var equipmentImageView: UIImageView!
    @IBOutlet var addImageButton: MyButton!
    @IBOutlet var removeEquipmentButton: MyButton!
    @IBOutlet var listOfUserButton: MyButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemsLabel.font = UIFont(name: secondaryFont, size: 20)
//        availableTextField.customize(forEditing: false)
        availableTextField.keyboardType = .numberPad
        availableTextField.textAlignment = .center
        
        addImageButton.customize(forCase: .primary)
        removeEquipmentButton.customize(forCase: .danger)
        listOfUserButton.customize(forCase: .primary)
    }
    
    static func instantiate(forCase viewCase: EquipmentInfoViewCase) -> EquipmentInfoView {
        let view: EquipmentInfoView = initFromNib()
        switch viewCase {
        case .equipmentInfoLabEdit:
            view.addImageButton.removeFromSuperview()
            view.removeEquipmentButton.removeFromSuperview()
            view.nameTextView.accessibilityIdentifier = AccessibilityId.labEquipmentEditNameTextView.description
            view.equipmentImageView.accessibilityIdentifier = AccessibilityId.labEquipmentEditEquipmentImageView.description
            
        case .equipmentCreate:
            view.removeEquipmentButton.removeFromSuperview()
            view.addImageButton.setTitle("Add Image", for: .normal)
            view.equipmentImageView.isHidden = true
            fallthrough
            
        case .equipmentInfo:
            view.availableTextField.accessibilityIdentifier = AccessibilityId.equipmentInfoAvailableTextField.description
            view.nameTextView.accessibilityIdentifier = AccessibilityId.equipmentInfoNameTextView.description
            view.locationTextView.accessibilityIdentifier = AccessibilityId.equipmentInfoLocationTextView.description
            view.descriptionTextView.accessibilityIdentifier = AccessibilityId.equipmentInfoDescriptionTextView.description
            view.equipmentImageView.accessibilityIdentifier = AccessibilityId.equipmentInfoImageView.description
            view.addImageButton.accessibilityIdentifier = AccessibilityId.equipmentInfoAddImageButton.description
            view.removeEquipmentButton.accessibilityIdentifier = AccessibilityId.equipmentInfoRemoveEquipmentButton.description
            view.listOfUserButton.accessibilityIdentifier = AccessibilityId.equipmentInfoListOfUserButton.description
        }
        return view
    }
    
    var viewModel: EquipmentInfoVM! {
        didSet {
//            availableTextField.customize(forEditing: false)
            availableTextField.text = viewModel.availableString
            
            nameTextView.text = viewModel.equipmentName
            locationTextView.text = viewModel.location
            descriptionTextView.text = viewModel.description
//            do {
//                let url = URL(string: viewModel.imageUrl)!
//                let data = try Data(contentsOf: url)
//                equipmentImageView.image = UIImage(data: data)
//            }
//            catch{
//                print(error)
//            }
            
            let url = URL(string: viewModel.imageUrl)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.equipmentImageView.image = UIImage(data: data!)
                }
            }
        }
    }
    
    
    func update(forEditing isBeingEdited: Bool) {
        addImageButton.isHidden = !isBeingEdited
        removeEquipmentButton.isHidden = !isBeingEdited
        listOfUserButton.isHidden = isBeingEdited
        availableTextField.customize(forEditing: isBeingEdited)
        nameTextView.customize(forEditing: isBeingEdited)
        locationTextView.customize(forEditing: isBeingEdited)
        descriptionTextView.customize(forEditing: isBeingEdited)
    }
}
