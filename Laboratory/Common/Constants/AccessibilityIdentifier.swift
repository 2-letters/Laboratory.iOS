//
//  AccessibilityId.swift
//  Laboratory
//
//  Created by Developers on 6/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

enum AccessibilityId {
    // Lab Collection VC
    case labCollectionAddButton
    case labCollectionSearchBar
    case labCollectionView
    
    // Lab Info VC
    case labInfoMainView
    case labInfoSaveButton
    case labInfoNameTextView
    case labInfoDescriptionTextView
    case labInfoAddEquipmentButton
    case labInfoRemoveLabButton
    case labInfoTableView
    
    // Lab Equipment Selection VC
    case labEquipmentSelectionDoneButton
    case labEquipmentSelectionSearchBar
    case labEquipmentSelectionTableView
    
    // Lab Equipment Edit VC
    case labEquipmentEditBackButton
    case labEquipmentEditScrollView
    case labEquipmentEditSaveButton
    case labEquipmentEditUsingQuantityTextField
    case labEquipmentEditDecreaseButton
    case labEquipmentEditIncreaseButton
    case labEquipmentEditRemoveButton
    case labEquipmentEditNameTextView
    case labEquipmentEditEquipmentImageView
    
    // Equipment List VC
    case equipmentListAddButton
    case equipmentListSearchBar
    case equipmentListTableView
    
    // Equipment Info VC
    // todo: this is made up, make it real
    case equipmentInfoScrollView
    case equipmentInfoAvailableTextField
    case equipmentInfoNameTextView
    case equipmentInfoDescriptionTextView
    case equipmentInfoLocationTextView
    
    // Equipment User List VC
    case equipmentUserListTableView
    case equipmentUserListDoneButton
    
    var description: String {
        return String(describing: self)
    }
}
