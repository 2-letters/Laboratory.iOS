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
    @IBOutlet var deleteEquipmentButton: MyButton!
    @IBOutlet var listOfUserButton: MyButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemsLabel.font = UIFont(name: "GillSans", size: 20)
        availableTextField.keyboardType = .numberPad
        availableTextField.textAlignment = .center
        
        addImageButton.customize(forCase: .primary)
        deleteEquipmentButton.customize(forCase: .danger)
        listOfUserButton.customize(forCase: .primary)
    }
    
    static func instantiate(forCase viewCase: EquipmentInfoViewCase) -> EquipmentInfoView {
        let view: EquipmentInfoView = initFromNib()
        switch viewCase {
        case .equipmentInfoLabEdit:
            view.addImageButton.removeFromSuperview()
            view.deleteEquipmentButton.removeFromSuperview()
            view.availableTextField.accessibilityIdentifier = AccessibilityId.labEquipmentEditAvailableTextField.description
            view.equipmentImageView.accessibilityIdentifier = AccessibilityId.labEquipmentEditEquipmentImageView.description
            
        case .equipmentCreate:
            view.deleteEquipmentButton.removeFromSuperview()
            view.listOfUserButton.removeFromSuperview()
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
            view.deleteEquipmentButton.accessibilityIdentifier = AccessibilityId.equipmentInfoDeleteEquipmentButton.description
            view.listOfUserButton.accessibilityIdentifier = AccessibilityId.equipmentInfoListOfUserButton.description
        }
        return view
    }
    
    var viewModel: EquipmentInfoVM! {
        didSet {
            availableTextField.text = viewModel.availableString
            nameTextView.text = viewModel.equipmentName
            locationTextView.text = viewModel.location
            descriptionTextView.text = viewModel.description
            
            loadImage(withUrl: viewModel.imageUrl)
        }
    }
    
    private func loadImage(withUrl url: String) {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: url)!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.equipmentImageView.image = UIImage(data: data!)
            }
        }
    }
    
    func updateForEditing() {
        addImageButton.isHidden = false
        deleteEquipmentButton.isHidden = false
        listOfUserButton.isHidden = true
        
        availableTextField.customizeForEditing()
        
        nameTextView.customize(forEditing: true)
        locationTextView.customize(forEditing: true)
        descriptionTextView.customize(forEditing: true)
    }
    
    func updateForViewOnly() {
        addImageButton.isHidden = true
        deleteEquipmentButton.isHidden = true
        listOfUserButton.isHidden = false
        
        availableTextField.customizeForViewOnly()
        
        nameTextView.customize(forEditing: false)
        locationTextView.customize(forEditing: false)
        descriptionTextView.customize(forEditing: false)
    }
}
