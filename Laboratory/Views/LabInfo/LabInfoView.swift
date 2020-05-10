//
//  LabInfoView.swift
//  Laboratory
//
//  Created by Huy Vo on 5/12/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabInfoView: UIView {

//    @IBOutlet var contentView: UIView!
//    static let nibName = "LabInfoView"
    
    @IBOutlet var nameTextView: MyTextView!
    
    @IBOutlet var descriptionTextView: MyTextView!
    
    @IBOutlet var addEquipmentButton: UIButton!
    
    @IBOutlet var deleteLabButton: UIButton!
    
    @IBOutlet var labEquipmentTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameTextView.customize(forEditing: true)
        descriptionTextView.customize(forEditing: true)
        
        customizeButtons()
    }
    
    private func customizeButtons() {
        addEquipmentButton.backgroundColor = MyColor.lightGreen
        addEquipmentButton.setTitleColor(UIColor.white, for: .normal)
        addEquipmentButton.titleLabel?.font = UIFont(name: "GillSans", size: 17)
        
        deleteLabButton.backgroundColor = MyColor.superLightGreen
        deleteLabButton.setTitleColor(MyColor.redWarning, for: .normal)
        deleteLabButton.titleLabel?.font = UIFont(name: "GillSans", size: 17)
    }
    
    static func instantiate() -> LabInfoView {
        let view: LabInfoView = initFromNib()
        
        view.nameTextView.accessibilityIdentifier = AccessibilityId.labInfoNameTextView.description
        view.descriptionTextView.accessibilityIdentifier = AccessibilityId.labInfoDescriptionTextView.description
        view.addEquipmentButton.accessibilityIdentifier = AccessibilityId.labInfoAddEquipmentButton.description
        view.deleteLabButton.accessibilityIdentifier = AccessibilityId.labInfoDeleteLabButton.description
        view.labEquipmentTableView.accessibilityIdentifier = AccessibilityId.labInfoTableView.description

        return view
    }
    
    var labInfoVM: LabInfoViewModel! {
        didSet {
            nameTextView.text = labInfoVM.labName
            descriptionTextView.text = labInfoVM.description
        }
    }
}
