//
//  EquipmentSvc.swift
//  Laboratory
//
//  Created by Huy Vo on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum AllEquipmentResult {
    case success([SimpleEquipmentVM])
    case failure(String)
}

enum EquipmentInfoResult {
    case success(EquipmentInfoVM)
    case failure(String)
}

struct EquipmentSvc {
    static func fetchAllEquipments(completion: @escaping (AllEquipmentResult) -> Void) {
        var equipmentVMs = [SimpleEquipmentVM]()
        Firestore.firestore().collection("institutions").document("MXnWedK2McfuhBpVr3WQ").collection("items").order(by: "name", descending: false).getDocuments { (snapshot, error) in
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Equipments data"))
            } else {
                for document in (snapshot!.documents) {
                    if let equipmentName = document.data()["name"] as? String
//                        let description = document.data()["description"] as? String,
//                        let quantity = document.data()["quantity"] as? Int,
//                        let location = document.data()["location"] as? String,
//                        let photoUrl = document.data()["photoUrl"] as? String
                    {
                        equipmentVMs.append(SimpleEquipmentVM(equipment: Equipment(name: equipmentName)))
                    }
//                    guard let equipmentName = document.data()["equipmentName"] else {
//                        return
//                    }
//                    guard let ite
                }
                completion(.success(equipmentVMs))
            }
        }
    }
    
    static func fetchEquipmentInfo(byName name: String, completion: @escaping (EquipmentInfoResult) -> Void) {
        // TODO: get department and instituion from Cache?
    Firestore.firestore().collection("institutions").document("MXnWedK2McfuhBpVr3WQ").collection("items").whereField("name", isEqualTo: name).getDocuments { (snapshot, error) in
        if error != nil {
            completion(.failure(error?.localizedDescription ?? "ERR fetching Equipment Info data"))
        } else {
            let document = snapshot!.documents.first!
            if let equipmentName = document.data()["name"] as? String,
                let quantity = document.data()["quantity"] as? Int,
                let description = document.data()["description"] as? String,
                let location = document.data()["location"] as? String,
                let pictureUrl = document.data()["pictureUrl"] as? String
            {
                completion(.success(EquipmentInfoVM(equipment: FullEquipment(name: equipmentName, quantity: quantity, description: description, location: location, pictureUrl: pictureUrl))))
            } else {
                completion(.failure(error?.localizedDescription ?? "ERR converting Equipment Info into Equipment class"))
            }
        }
        }
    }
}
