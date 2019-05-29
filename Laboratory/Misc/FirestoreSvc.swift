//
//  FirestoreSvc.swift
//  Laboratory
//
//  Created by Developers on 5/28/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

typealias FetchLabEquipmentHandler = (FetchLabEquipmentResult) -> Void

enum FetchLabEquipmentResult {
    case success([LabEquipment])
    case failure(String)
}

struct FirestoreSvc {
    static func fetchLabEquipments(byLabName labName: String, completion: @escaping FetchLabEquipmentHandler) {
        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6")
            .collection("labs").document(labName).collection("equipments")
            .getDocuments { (snapshot, error) in
                if error != nil {
                    completion(.failure(error?.localizedDescription
                        ?? "ERR fetching Lab Equipments data"))
                } else {
                    var addedEquipments = [LabEquipment]()
                    for document in (snapshot!.documents) {
                        if let equipmentName = document.data()["equipmentName"] as? String,
                            let using = document.data()["using"] as? Int {
                            addedEquipments.append(LabEquipment(name: equipmentName, using: using))
                        }
                    }
                    completion(.success(addedEquipments))
                }
        }
    }
}
