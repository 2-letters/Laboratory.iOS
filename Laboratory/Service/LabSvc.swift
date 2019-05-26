//
//  LabAssignmentSvc.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore





struct LabSvc {
//    static func fetchLabData(completion: @escaping (LabResult) -> Void) {
//        var labVMs = [LabVM]()
//        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").order(by: "labName", descending: false).getDocuments { (snapshot, error) in
//            if error != nil {
//                completion(.failure(error?.localizedDescription ?? "ERR fetching Labs data"))
//            } else {
//                for document in (snapshot!.documents) {
//                    if let labName = document.data()["labName"] as? String {
//                        labVMs.append(LabVM(lab: Lab(name: labName)))
//                        completion(.success(labVMs))
//                    }
//                }
//            }
//        }
//    }
    
//    static func fetchLabEquipment(byName labName: String, completion: @escaping (LabEquipmentResult) -> Void) {
//        var labEquipments = [LabEquipment]()
//        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").document("labName").collection("equipments").order(by: "itemName", descending: false)
//            .getDocuments { (snapshot, error) in
//            
//                if error != nil {
//                    completion(.failure(error?.localizedDescription ?? "ERR fetching Lab Equipments data"))
//                } else {
//                    for document in (snapshot!.documents)
//                    {
//                        guard let equipmentName = document.data()["itemName"] as? String,
//                            let quantity =
//                            document.data()["quantity"] as? Int
//                            else
//                        {
//                            completion(.failure("ERR reading datas from Lab Equipment"))
//                            return
//                        }
//                        labEquipments.append(LabEquipment(
//                            name: equipmentName, quantity: quantity))
//                    }
//                    completion(.success(labEquipments))
//                }
//        }
//    }
    
    static func createLab(withName name: String, description: String) {
        let newLab = ["name" : name,
                      "description": description]
        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").document(name).setData(newLab) { err in
                if let err = err {
                    print("ERR creating a new Lab \(err)")
                } else {
                    print("Successfully added new lab: \(name)")
                }
        }
    }
}
