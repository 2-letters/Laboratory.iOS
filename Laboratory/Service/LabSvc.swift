//
//  LabAssignmentSvc.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum LabResult {
    case success([LabVM])
    case failure(String)
}

enum LabEquipmentEditResult {
    case success([LabEquipmentSelectionVM])
    case failure(String)
}


struct LabSvc {
    static func fetchLabData(completion: @escaping (LabResult) -> Void) {
        var labVMs = [LabVM]()
        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").order(by: "labName", descending: false).getDocuments { (snapshot, error) in
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Labs data"))
            } else {
                for document in (snapshot!.documents) {
                    if let labName = document.data()["labName"] as? String {
                        if let description = document.data()["description"] as? String {
                            labVMs.append(LabVM(Lab(name: labName, description: description)))
                            completion(.success(labVMs))
                        }
                    }
                }
            }
        }
    }
    
    static func fetchLabEquipment(completion: @escaping (LabEquipmentEditResult) -> Void) {
        var labEquipmentSelectionVMs = [LabEquipmentSelectionVM]()
        Firestore.firestore().collection("labItems").order(by: "itemName", descending: false)
            .getDocuments { (snapshot, error) in
            
                if error != nil {
                    completion(.failure(error?.localizedDescription ?? "ERR fetching Lab Items data"))
                } else {
                    for document in (snapshot!.documents) {
                        guard let equipmentName = document.data()["itemName"] as? String else {
                            completion(.failure("ERR fetching Lab Equipment name"))
                            return
                        }
//                        guard let quantity = document.data()["quantity"] as? Int else {
//                            completion(.failure("ERR fetching Lab Equipment name"))
//                            return
//                        }
                        labEquipmentSelectionVMs.append(LabEquipmentSelectionVM(LabEquipment(equipmentName: equipmentName)))
                        completion(.success(labEquipmentSelectionVMs))
                    }
                    completion(.success(labEquipmentSelectionVMs))
                }
        }
    }
    
    static func createLab(withName name: String, description: String) {
        let newLab = ["name" : name,
                      "description": description]
        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").addDocument(data: newLab) { err in
                if let err = err {
                    print("ERR creating a new Lab \(err)")
                } else {
                    print("Successfully added new lab: \(name)")
                }
        }
    }
}
