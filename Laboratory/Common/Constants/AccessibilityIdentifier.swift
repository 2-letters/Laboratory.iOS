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
    case labInfoSaveButton
    case labInfoNameTextField
    case labInfoDescriptionTextField
    case labInfoAddEquipmentButton
    case labInfoTableView
    
    // Lab Equipment Selection VC
    case labEquipmentSelectionDoneButton
    case labEquipmentSelectionSearchBar
    case labEquipmentSelectionTableView
    
    // Lab Equipment Edit VC
    case labEquipmentEditScrollView
    case labEquipmentEditSaveButton
    case labEquipmentEditUsingQuantityTextField
    case labEquipmentEditDecreaseButton
    case labEquipmentEditIncreaseButton
    case labEquipmentEditRemoveButton
    case labEquipmentEditNameLabel
    
    // Equipment List VC
    case equipmentListAddButton
    case equipmentListSearchBar
    case equipmentListTableView
    
    // Equipment Info VC
    // todo: this is made up, make it real
    case equipmentInfoScrollView
    
    var value: String {
        return String(describing: self)
    }
}

//struct AccessibilityIdentifier {
//    // Lab Collection VC
//    static let labCollectionNavigationBar = "labCollectionNavigationBar"
//    static let labCollectionSearchBar = "labCollectionSearchBar"
//    static let labCollectionView = "labCollectionView"
//    
//    // Lab Info VC
//    static let labInfoSaveButton = "labInfoSaveNavigationButton"
//    static let labInfoNameTextField = "labInfoNameTextField"
//    static let labInfoDescriptionTextField = "labInfoDescriptionTextField"
//    static let labInfoAddEquipmentButton = "labInfoAddEquipmentButton"
//    static let labInfoTableView = "labInfoTableView"
//    
//    // Lab Equipment Selection VC
//    static let labEquipmentSelectionDoneButton = "labEquipmentSelectionDoneButton"
//}
