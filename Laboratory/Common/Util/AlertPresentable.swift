//
//  UIViewController+presentAlert.swift
//  Laboratory
//
//  Created by Developers on 6/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit


enum AlertCase {
    case succeedToSaveLab

    case failToLoadEquipments
    case failToLoadLabEquipments
    case failToLoadEquipmentInfo
    case failToSaveLab
    case failToSaveEdit
    case failToSaveEquipment
    case failToRemoveLab
    case failToRemoveEquipment

    case attemptCreateLab
    case attemptToRemoveLab
    case attemptToRemoveEquipment

    case invalidLabInfoInput
    case invalidEquipmentInfoInput
    
    var description: String {
        return String(describing: self)
    }
}

struct AlertString {
    static let okay = "Okay"
    static let yes = "Yes"
    static let no = "No"
    static let oops = "Oops!"
    
    // Titles
    static let succeedToSaveLabTitle = "Successfully saved this lab"
    static let failToLoadLabEquipmentsTitle = "Cannot load equipments"
    static let failToSaveEditTitle = "Cannot save this edit"
    static let failToSaveLabTitle = "Cannot save this Lab"
    static let failToSaveEquipmentTitle = "Cannot save this Equipment"
    static let failToRemoveLabTitle = "Cannot delete this Lab"
    static let failToRemoveEquipmentTitle = "Cannot delete this Equipment"
    
    static let attempToCreateLabTitle = "Create Lab is required"
    static let attemptToRemoveLabTitle = "Confirm Lab Deletion"
    static let attemptToRemoveEquipmentTitle = "Confirm Equipment Deletion"
    
    // Messages
    static let succeedToSaveLabMessage = "Your lab has been successfully saved"
    static let failToLoadLabEquipmentsMessage = "Fail to load equipments for this lab. Please try again later"
    static let failToSaveLabMesage = "Fail to save this lab. Please try again later"
    static let failToSaveEquipmentMessage = "Fail to save this equipment. Please try again later"
    static let failToSaveEditMessage = "Fail to save this edit. Please try again later"
    static let failToRemoveLabMessage = "Fail to delete this lab. Please try again later"
    static let failToRemoveEquipmentMessage = "Fail to delete this equipment. Please try again later"
    
    static let attemptToCreateLabMessage = "Create a Lab is required to add equipments. Would you like to create this Lab?"
    static let attemptToRemoveLabMessage = "Are you sure you want to delete this lab?"
    static let attemptToRemoveEquipmentMessage = "Are you sure you want to delete this equipment?"
    
    static let invalidLabInfoMessage = "Please make sure your lab has both name and description"
    static let invalidEquipmentInfoMessage = "Please make sure you have all information for the equipment provided"
    
    static let pleaseTryAgainLaterMessage = "Something went wrong. Please try again later."
}

protocol AlertPresentable {}
extension AlertPresentable where Self: UIViewController {
    func presentAlert(forCase alertCase: AlertCase, handler: ((UIAlertAction) -> Void)? = nil) {
        let ac: UIAlertController
        
        // add title and message
        switch alertCase {
        case .succeedToSaveLab:
            ac = UIAlertController(title: AlertString.succeedToSaveLabTitle, message: AlertString.succeedToSaveLabTitle, preferredStyle: .alert)
           
        case .failToLoadEquipments,
             .failToLoadEquipmentInfo:
            ac = UIAlertController(title: AlertString.oops, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
        case .failToLoadLabEquipments:
            ac = UIAlertController(title: AlertString.failToLoadLabEquipmentsTitle, message: AlertString.failToLoadLabEquipmentsMessage, preferredStyle: .alert)
        case .failToSaveLab:
            ac = UIAlertController(title: AlertString.failToSaveLabTitle, message: AlertString.failToSaveLabMesage, preferredStyle: .alert)
        case .failToSaveEquipment:
            ac = UIAlertController(title: AlertString.failToSaveEquipmentTitle, message: AlertString.failToSaveEquipmentMessage, preferredStyle: .alert)
        case .failToSaveEdit:
            ac = UIAlertController(title: AlertString.failToSaveEditTitle, message: AlertString.failToSaveEditMessage, preferredStyle: .alert)
        case .failToRemoveLab:
            ac = UIAlertController(title: AlertString.failToRemoveLabTitle, message: AlertString.failToRemoveLabMessage, preferredStyle: .alert)
        case .failToRemoveEquipment:
            ac = UIAlertController(title: AlertString.failToRemoveEquipmentTitle, message: AlertString.failToRemoveEquipmentMessage, preferredStyle: .alert)
            
        case .attemptCreateLab:
            ac = UIAlertController(title: AlertString.attempToCreateLabTitle, message: AlertString.attemptToCreateLabMessage, preferredStyle: .actionSheet)
        case .attemptToRemoveLab:
            ac = UIAlertController(title: AlertString.attemptToRemoveLabTitle, message: AlertString.attemptToRemoveLabMessage, preferredStyle: .actionSheet)
        case .attemptToRemoveEquipment:
            ac = UIAlertController(title: AlertString.attemptToRemoveEquipmentTitle, message: AlertString.attemptToRemoveEquipmentMessage, preferredStyle: .actionSheet)
            
        case .invalidLabInfoInput:
            ac = UIAlertController(title: AlertString.oops, message: AlertString.invalidLabInfoMessage, preferredStyle: .alert)
        case .invalidEquipmentInfoInput:
            ac = UIAlertController(title: AlertString.oops, message: AlertString.invalidEquipmentInfoMessage, preferredStyle: .alert)
        }
        
        // add Actions
        switch alertCase {
        case .succeedToSaveLab,
             .failToLoadEquipments,
             .failToLoadLabEquipments,
             .failToLoadEquipmentInfo,
             .invalidLabInfoInput,
             .invalidEquipmentInfoInput:
            ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: handler))
            
        case .failToSaveLab,
             .failToSaveEquipment,
             .failToSaveEdit,
             .failToRemoveLab,
             .failToRemoveEquipment:
            ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: nil))
            
        case .attemptCreateLab:
            ac.addAction(UIAlertAction(title: AlertString.yes, style: .default, handler: handler))
            ac.addAction(UIAlertAction(title: AlertString.no, style: .destructive, handler: nil))
        case .attemptToRemoveLab, .attemptToRemoveEquipment:
            ac.addAction(UIAlertAction(title: AlertString.yes, style: .destructive, handler: handler))
            ac.addAction(UIAlertAction(title: AlertString.no, style: .default, handler: nil))
        
        }
        
        // add Accessibility Identifier
        ac.view.accessibilityIdentifier = alertCase.description
        
        // check if the device is an iPad & set the proper source view & rect if it's needed, otherwise the app will crash on iPads
        if UIDevice.current.userInterfaceIdiom == .pad {
            // this maybe not be self.view, see ImagePicker, it is using the UIButton
            ac.popoverPresentationController?.sourceView = self.view
            ac.popoverPresentationController?.sourceRect = self.view.bounds
            ac.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        // present
        self.present(ac, animated: true, completion: nil)
    }
}
