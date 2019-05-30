//
//  AlertString.swift
//  Laboratory
//
//  Created by Developers on 5/23/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

struct AlertString {
    static let okay = "Okay"
    
    // Titles
    static let oopsTitle = "Oops"
    static let successTitle = "Success"
    static let createLabTitle = "Create a Lab"
    
    // Messages
    static let tryAgainMessage = "Some errors have occurred. Please try again later"
    static let failToSaveLabInfoMessage = "Please make sure your lab has both name and description"
    
    static let failToSaveLabEquipmentMessage = "Some errors have occurred. Cannot save changes for this equipment at the moment. Please try again later"
    static let succeedToSaveLabEquipmentMessage = "Successfully save for this equipment"
    static let attemptToAddLabEquipmentsMessage = "In order to add equipments, you must create a Lab first. Would you like to create this Lab with the given name?"
}
