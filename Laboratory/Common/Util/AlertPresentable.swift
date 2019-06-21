//
//  UIViewController+presentAlert.swift
//  Laboratory
//
//  Created by Developers on 6/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit


enum AlertCase {
    // invalid
    case invalidLabInfoInput
    // Creating
    case attemptCreateLabToAddEquipments
    // Reading/loading
    case failToLoadEquipments
    case failToLoadLabEquipments
    case failToLoadEquipmentInfo
    // Updating
    case failToSaveLab
    case succeedToSaveLab
    case failToSaveEquipmentEdit
    // Deleting
    case attemptToRemoveLab
    case failToRemoveLab
    
    var description: String {
        return String(describing: self)
    }
}

struct AlertString {
    static let okay = "Okay"
    static let yes = "Yes"
    static let no = "No"
    
    // Titles
    static let oopsTitle = "Oops!"
    //    static let successTitle = "Success"
    static let createLabRequiredTitle = "Create Lab is required"
    static let failToLoadLabEquipmentsTitle = "Failed to load equipments"
    static let failToSaveEditTitle = "Cannot save this edit"
    static let failToSaveLabTitle = "Cannot save this Lab"
    static let failToRemoveLabTitle = "Cannot delete this Lab"
    static let succeedToSaveLabTitle = "Successfully saved this lab"
    static let attemptToRemoveLabTitle = "Confirm Deletion"
    
    // Messages
    static let pleaseTryAgainLaterMessage = "Something went wrong. Please try again later."
    static let invalidLabInfoMessage = "Please make sure your lab has both name and description"
    static let failToLoadLabEquipmentsMessage = "Cannot load equipments for this lab. Please try again later"
    static let attemptToCreateLabToEquipmentsMessage = "Create a Lab is required to add equipments. Would you like to create this Lab?"
    static let attemptToRemoveLabMessage = "Are you sure you want to delete this lab?"
    static let failToRemoveLabMessage = "Fail to delete this lab. Please try again later"
    static let succeedToSaveLabMessage = "Your lab has been successfully saved"
    
}

protocol AlertPresentable {}
extension AlertPresentable where Self: UIViewController {
    func presentAlert(forCase alertCase: AlertCase, handler: ((UIAlertAction) -> Void)? = nil) {
        let ac: UIAlertController
        
        // add title and message
        switch alertCase {
        case .invalidLabInfoInput:
            ac = UIAlertController(title: AlertString.oopsTitle, message: AlertString.invalidLabInfoMessage, preferredStyle: .alert)
        case .attemptCreateLabToAddEquipments:
            ac = UIAlertController(title: AlertString.createLabRequiredTitle, message: AlertString.attemptToCreateLabToEquipmentsMessage, preferredStyle: .actionSheet)
            
        case .failToLoadEquipments, .failToLoadEquipmentInfo:
            ac = UIAlertController(title: AlertString.oopsTitle, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
        case .failToLoadLabEquipments:
            ac = UIAlertController(title: AlertString.failToLoadLabEquipmentsTitle, message: AlertString.failToLoadLabEquipmentsMessage, preferredStyle: .alert)
        // UPDATING
        case .failToSaveLab:
            ac = UIAlertController(title: AlertString.failToSaveLabTitle, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
        case .succeedToSaveLab:
            ac = UIAlertController(title: AlertString.succeedToSaveLabTitle, message: AlertString.succeedToSaveLabTitle, preferredStyle: .alert)
        case .failToSaveEquipmentEdit:
            ac = UIAlertController(title: AlertString.failToSaveEditTitle, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
            // DELETING
        case .failToRemoveLab:
            ac = UIAlertController(title: AlertString.failToRemoveLabTitle, message: AlertString.failToRemoveLabMessage, preferredStyle: .alert)
        case .attemptToRemoveLab:
            ac = UIAlertController(title: AlertString.attemptToRemoveLabTitle, message: AlertString.attemptToRemoveLabMessage, preferredStyle: .actionSheet)
        }
        // add Accessibility Identifier
        ac.view.accessibilityIdentifier = alertCase.description
        
        // add Actions
        switch alertCase {
        case .invalidLabInfoInput, .failToSaveLab, .succeedToSaveLab,
             .failToLoadEquipments, .failToLoadLabEquipments, .failToLoadEquipmentInfo:
            ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: handler))
        case .attemptCreateLabToAddEquipments:
            ac.addAction(UIAlertAction(title: AlertString.yes, style: .default, handler: handler))
            ac.addAction(UIAlertAction(title: AlertString.no, style: .destructive, handler: nil))
        case .attemptToRemoveLab:
            ac.addAction(UIAlertAction(title: AlertString.yes, style: .destructive, handler: handler))
            ac.addAction(UIAlertAction(title: AlertString.no, style: .default, handler: nil))
        case .failToSaveEquipmentEdit, .failToRemoveLab:
            ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: nil))
        }
        // present
        self.present(ac, animated: true, completion: nil)
    }
}
