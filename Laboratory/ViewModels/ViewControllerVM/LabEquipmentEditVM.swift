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
    
    var available: Int {
        return equipmentInfoVM.equipment?.available ?? 0
    }
    
    func updateEquipmentUsing(forLabId labId: String, equipmentName: String, newUsing: Int, completion: @escaping UpdateFirestoreHandler) {
        // Add a new document in collection "cities"
        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").document(labId).collection("equipments").document(equipmentName).setData([
            "equipmentName": equipmentName,
            "using": newUsing
        ]) { err in
            if let err = err {
                completion(.failure(err.localizedDescription + "ERR fail to update Equipment using"))
            } else {
                print("Successfully update Equipment using!")
                completion(.success)
            }
        }
    }
}
