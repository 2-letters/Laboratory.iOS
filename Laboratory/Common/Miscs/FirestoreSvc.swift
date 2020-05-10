//
//  FirestoreSvc.swift
//  Laboratory
//
//  Created by Developers on 5/28/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct FirestoreSvc {
//    static let firestoreUtil = FirestoreUtil.shared
    static func fetchAllEquipments(completion: @escaping FetchAllEquipmentHandler) {
        FirestoreUtil.fetchAllEquipmentsOrdered().getDocuments { (snapshot, error) in
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Equipment data"))
            } else {
                var equipmentVMs = [SimpleEquipmentVM]()
                for document in (snapshot!.documents) {
                    if let equipmentName = document.data()[EquipmentKey.name] as? String
                    { equipmentVMs.append(SimpleEquipmentVM(equipment: Equipment(id: document.documentID, name: equipmentName)))
                    }
                }
                completion(.success(equipmentVMs))
            }
        }
    }
    
    static func fetchLabEquipments(byLabId labId: String, completion: @escaping FetchLabEquipmentHandler) {
        FirestoreUtil.fetchLabEquipments(withId: labId).getDocuments { (snapshot, error) in
                if error != nil {
                    completion(.failure(error?.localizedDescription
                        ?? "ERR fetching Lab Equipment data"))
                } else {
                    var addedEquipments = [LabEquipment]()
                    for document in (snapshot!.documents) {
                        if let equipmentName = document.data()[EquipmentKey.name] as? String,
                            let using = document.data()[EquipmentKey.using] as? Int {
                            if using != 0 {
                                addedEquipments.append(LabEquipment(id: document.documentID, name: equipmentName, using: using))
                            }
                        }
                    }
                    completion(.success(addedEquipments))
                }
        }
    }
}
