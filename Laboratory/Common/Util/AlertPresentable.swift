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
    case succeedToSaveEquipment

    case failToLoadEquipments
    case failToLoadLabEquipments
    case failToLoadEquipmentInfo
    case failToLoadEquipmentUser
    case failToSaveLab
    case failToSaveEdit
    case failToSaveEquipment
    case failToDeleteLab
    case failToDeleteEquipment

    case attemptCreateLab
    case attemptToDeleteLab
    case attemptToDeleteEquipment

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
    static let succeedToSaveEquipmentTitle = "Successfully saved this equipment"
    static let failToLoadLabEquipmentsTitle = "Cannot load equipments"
    static let failToLoadEquipmentUserTitle = "Cannot load users"
    static let failToSaveEditTitle = "Cannot save this edit"
    static let failToSaveLabTitle = "Cannot save this Lab"
    static let failToSaveEquipmentTitle = "Cannot save this Equipment"
    static let failToDeleteLabTitle = "Cannot delete this Lab"
    static let failToDeleteEquipmentTitle = "Cannot delete this Equipment"
    
    static let attempToCreateLabTitle = "Create Lab is required"
    static let attemptToDeleteLabTitle = "Confirm Lab Deletion"
    static let attemptToDeleteEquipmentTitle = "Confirm Equipment Deletion"
    
    // Messages
    static let succeedToSaveLabMessage = "Your lab has been successfully saved"
    static let succeedToSaveEquipmentMessage = "Your equipment has been successfully saved"
    static let failToLoadLabEquipmentsMessage = "Fail to load equipments for this lab. Please try again later"
    static let failToLoadEquipmentUserMessage = "Fail to load users for this equipment"
    static let failToSaveLabMesage = "Fail to save this lab. Please try again later"
    static let failToSaveEquipmentMessage = "Fail to save this equipment. Please try again later"
    static let failToSaveEditMessage = "Fail to save this edit. Please try again later"
    static let failToDeleteLabMessage = "Fail to delete this lab. Please try again later"
    static let failToDeleteEquipmentMessage = "Fail to delete this equipment. Please try again later"
    
    static let attemptToCreateLabMessage = "Create a Lab is required to add equipments. Would you like to create this Lab?"
    static let attemptToDeleteLabMessage = "Are you sure you want to delete this lab?"
    static let attemptToDeleteEquipmentMessage = "Are you sure you want to delete this equipment?"
    
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
        case .succeedToSaveEquipment:
            ac = UIAlertController(title: AlertString.succeedToSaveEquipmentTitle, message: AlertString.succeedToSaveEquipmentMessage, preferredStyle: .alert)
           
        case .failToLoadEquipments,
             .failToLoadEquipmentInfo:
            ac = UIAlertController(title: AlertString.oops, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
        case .failToLoadLabEquipments:
            ac = UIAlertController(title: AlertString.failToLoadLabEquipmentsTitle, message: AlertString.failToLoadLabEquipmentsMessage, preferredStyle: .alert)
        case .failToLoadEquipmentUser:
            ac = UIAlertController(title: AlertString.failToLoadEquipmentUserTitle, message: AlertString.failToLoadEquipmentUserMessage, preferredStyle: .alert)
        case .failToSaveLab:
            ac = UIAlertController(title: AlertString.failToSaveLabTitle, message: AlertString.failToSaveLabMesage, preferredStyle: .alert)
        case .failToSaveEquipment:
            ac = UIAlertController(title: AlertString.failToSaveEquipmentTitle, message: AlertString.failToSaveEquipmentMessage, preferredStyle: .alert)
        case .failToSaveEdit:
            ac = UIAlertController(title: AlertString.failToSaveEditTitle, message: AlertString.failToSaveEditMessage, preferredStyle: .alert)
        case .failToDeleteLab:
            ac = UIAlertController(title: AlertString.failToDeleteLabTitle, message: AlertString.failToDeleteLabMessage, preferredStyle: .alert)
        case .failToDeleteEquipment:
            ac = UIAlertController(title: AlertString.failToDeleteEquipmentTitle, message: AlertString.failToDeleteEquipmentMessage, preferredStyle: .alert)
            
        case .attemptCreateLab:
            ac = UIAlertController(title: AlertString.attempToCreateLabTitle, message: AlertString.attemptToCreateLabMessage, preferredStyle: .actionSheet)
        case .attemptToDeleteLab:
            ac = UIAlertController(title: AlertString.attemptToDeleteLabTitle, message: AlertString.attemptToDeleteLabMessage, preferredStyle: .actionSheet)
        case .attemptToDeleteEquipment:
            ac = UIAlertController(title: AlertString.attemptToDeleteEquipmentTitle, message: AlertString.attemptToDeleteEquipmentMessage, preferredStyle: .actionSheet)
            
        case .invalidLabInfoInput:
            ac = UIAlertController(title: AlertString.oops, message: AlertString.invalidLabInfoMessage, preferredStyle: .alert)
        case .invalidEquipmentInfoInput:
            ac = UIAlertController(title: AlertString.oops, message: AlertString.invalidEquipmentInfoMessage, preferredStyle: .alert)
        }
        
        // add Actions
        switch alertCase {
        case .succeedToSaveLab,
             .succeedToSaveEquipment,
             .failToLoadEquipments,
             .failToLoadLabEquipments,
             .failToLoadEquipmentInfo,
             .failToLoadEquipmentUser,
             .invalidLabInfoInput,
             .invalidEquipmentInfoInput:
            ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: handler))
            
        case .failToSaveLab,
             .failToSaveEquipment,
             .failToSaveEdit,
             .failToDeleteLab,
             .failToDeleteEquipment:
            ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: nil))
            
        case .attemptCreateLab:
            ac.addAction(UIAlertAction(title: AlertString.yes, style: .default, handler: handler))
            ac.addAction(UIAlertAction(title: AlertString.no, style: .destructive, handler: nil))
        case .attemptToDeleteLab, .attemptToDeleteEquipment:
            ac.addAction(UIAlertAction(title: AlertString.yes, style: .destructive, handler: handler))
            ac.addAction(UIAlertAction(title: AlertString.no, style: .default, handler: nil))
        
        }
        
        // add Accessibility Identifier
        ac.view.accessibilityIdentifier = alertCase.description
        
        // TODO break this function
        
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
