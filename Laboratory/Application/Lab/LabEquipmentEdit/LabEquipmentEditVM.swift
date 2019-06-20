//
//  LabEquipmentEditVM.swift
//  Laboratory
//
//  Created by Developers on 5/28/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct LabEquipmentEditVM {
    var equipmentInfoVM = EquipmentInfoVM()
    
    var usingQuantity = 0 {
        didSet {
            editingQuantity = usingQuantity
        }
    }
    var editingQuantity = 0
    
    var equipmentName: String {
        return equipmentInfoVM.equipment!.name
        
    }
    var available: Int {
        return equipmentInfoVM.equipment!.available
    }
    var isDecreaseBtnEnabled: Bool {
        return editingQuantity != 0
    }
    var isIncreaseBtnEnabled: Bool {
        return editingQuantity != available
    }
    var isRemoveBtnEnabled: Bool {
        return editingQuantity != 0
    }
    // "Save" button is only enable when there's change in quantity
    var isSaveBtnEnabled: Bool {
        return editingQuantity != usingQuantity
    }
    
    
    func updateEquipmentUsing(forLabId labId: String, equipmentId: String, completion: @escaping UpdateFirestoreHandler) {
        // Add a new document in collection "cities"
        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").document(labId).collection("equipments").document(equipmentId).setData([
            "equipmentName": equipmentName,
            "using": editingQuantity
        ]) { err in
            if let err = err {
                completion(.failure(err.localizedDescription + "ERR fail to update Equipment using"))
            } else {
                print("Successfully update Equipment using!")
                completion(.success(nil))
            }
        }
    }
    
    mutating func updateQuantityTextField(withText text: String?) {
        var inputedQuantity = Int(text ?? "0") ?? 0
        if inputedQuantity > available {
            inputedQuantity = available
        }
        editingQuantity = inputedQuantity
    }
}
