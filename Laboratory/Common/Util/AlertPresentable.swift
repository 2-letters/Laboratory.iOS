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
    case createLabToAddEquipments
    // Reading/loading
    case failToLoadEquipments
    case failToLoadLabEquipments
    case failToLoadEquipmentInfo
    // Updating
    case failToSaveLab
    case succeedToSaveLab
    case failToSaveEquipmentEdit
    
}

struct AlertString {
    static let okay = "Okay"
    
    // Titles
    static let oopsTitle = "Oops!"
    //    static let successTitle = "Success"
    static let createLabRequiredTitle = "Create Lab is required"
    static let failToLoadLabEquipmentsTitle = "Failed to load equipments"
    static let failToSaveEditTitle = "Cannot save this edit"
    static let failToSaveLabTitle = "Cannot save this Lab"
    static let succeedToSaveLabTitle = "Successfully saved this lab"
    
    // Messages
    static let pleaseTryAgainLaterMessage = "Something went wrong. Please try again later."
    static let invalidLabInfoMessage = "Please make sure your lab has both name and description"
    static let failToLoadLabEquipmentsMessage = "Cannot load equipments for this lab. Please try again later"
    //    static let succeedToSaveLabEquipmentMessage = "Successfully save for this equipment"
    static let attemptToCreateLabToEquipmentsMessage = "Create a Lab is required to add equipments. Would you like to create this Lab?"
    static let succeedToSaveLabMessage = "Your lab has been successfully saved"
}

protocol AlertPresentable {}
extension AlertPresentable {
    func presentAlert(forCase alertCase: AlertCase, handler: ((UIAlertAction) -> Void)? = nil) {
        let ac: UIAlertController
        
        // add title and message
        switch alertCase {
        case .invalidLabInfoInput:
            ac = UIAlertController(title: AlertString.oopsTitle, message: AlertString.invalidLabInfoMessage, preferredStyle: .alert)
            
        case .createLabToAddEquipments:
            ac = UIAlertController(title: AlertString.createLabRequiredTitle, message: AlertString.attemptToCreateLabToEquipmentsMessage, preferredStyle: .alert)
            
        case .failToLoadEquipments, .failToLoadEquipmentInfo:
            ac = UIAlertController(title: AlertString.oopsTitle, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
        case .failToLoadLabEquipments:
            ac = UIAlertController(title: AlertString.failToLoadLabEquipmentsTitle, message: AlertString.failToLoadLabEquipmentsMessage, preferredStyle: .alert)
            
        case .failToSaveLab:
            ac = UIAlertController(title: AlertString.failToSaveLabTitle, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
        case .succeedToSaveLab:
            ac = UIAlertController(title: AlertString.succeedToSaveLabTitle, message: AlertString.succeedToSaveLabTitle, preferredStyle: .alert)
        case .failToSaveEquipmentEdit:
            ac = UIAlertController(title: AlertString.failToSaveEditTitle, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
        }
        
        // add Actions
        switch alertCase {
        case .invalidLabInfoInput, .failToSaveLab, .succeedToSaveLab,
             .failToLoadEquipments, .failToLoadLabEquipments, .failToLoadEquipmentInfo:
            ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: handler))
        case .createLabToAddEquipments:
            ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: handler))
            ac.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        case .failToSaveEquipmentEdit:
            ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: nil))
        }
        // present
        UIApplication.shared.keyWindow?.rootViewController?.present(ac, animated: true, completion: nil)
    }
}

//extension UIViewController {
//
//    func presentAlert(forCase alertCase: AlertCase, handler: ((UIAlertAction) -> Void)? = nil) {
//        let ac: UIAlertController
//
//        // add title and message
//        switch alertCase {
//        case .invalidLabInfoInput:
//            ac = UIAlertController(title: AlertString.oopsTitle, message: AlertString.invalidLabInfoMessage, preferredStyle: .alert)
//
//        case .createLabToAddEquipments:
//            ac = UIAlertController(title: AlertString.createLabRequiredTitle, message: AlertString.attemptToCreateLabToEquipmentsMessage, preferredStyle: .alert)
//
//        case .failToLoadEquipments, .failToLoadEquipmentInfo:
//            ac = UIAlertController(title: AlertString.oopsTitle, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
//        case .failToLoadLabEquipments:
//            ac = UIAlertController(title: AlertString.failToLoadLabEquipmentsTitle, message: AlertString.failToLoadLabEquipmentsMessage, preferredStyle: .alert)
//
//        case .failToSaveLab:
//            ac = UIAlertController(title: AlertString.failToSaveLabTitle, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
//        case .succeedToSaveLab:
//            ac = UIAlertController(title: AlertString.succeedToSaveLabTitle, message: AlertString.succeedToSaveLabTitle, preferredStyle: .alert)
//        case .failToSaveEquipmentEdit:
//            ac = UIAlertController(title: AlertString.failToSaveEditTitle, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
//        }
//
//        // add Actions
//        switch alertCase {
//        case .invalidLabInfoInput, .failToSaveLab, .succeedToSaveLab,
//            .failToLoadEquipments, .failToLoadLabEquipments, .failToLoadEquipmentInfo:
//            ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: handler))
//        case .createLabToAddEquipments:
//            ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: handler))
//            ac.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
//        case .failToSaveEquipmentEdit:
//            ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: nil))
//        }
//        // present
//        self.present(ac, animated: true, completion: nil)
//    }
//}
