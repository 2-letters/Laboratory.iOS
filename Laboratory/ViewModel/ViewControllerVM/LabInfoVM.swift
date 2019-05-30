//
//  LabInfoVM.swift
//  Laboratory
//
//  Created by Developers on 5/21/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore


class LabInfoVM {
    var labInfo: LabInfo?
    
    var labName: String { return labInfo!.name }
    var description: String { return labInfo!.description }
    var equipmentVMs: [LabEquipmentVM]? {
        return labInfo?.equipments.map({ LabEquipmentVM(equipment: $0) })
    }
    
    func fetchLabInfo(byId labId: String?, completion: @escaping FetchFirestoreHandler) {
        guard let labId = labId else {
            completion(.failure("ERR could not load Lab Id"))
            return
        }
        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").document(labId)
        .getDocument { [unowned self] (document, error) in
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Lab Info"))
            } else {
                if let labName = document!.data()!["labName"] as? String,
                let description = document!.data()!["description"] as? String {
                    FirestoreSvc.fetchLabEquipments(byLabId: labId, completion: { (fetchLabEquipmentResult) in
                        switch fetchLabEquipmentResult {
                        case let .success(labEquipments):
                            self.labInfo = LabInfo(name: labName, description: description, equipments: labEquipments)
                            completion(.success)
                        case let .failure(errorStr):
                            completion(.failure(errorStr))
                        }
                    })
                } else {
                    completion(.failure("ERR converting Lab Info data"))
                }
            }
//            if let labInfo = document.flatMap({
//                $0.data().flatMap({ (data) in
//                    return LabInfo(dictionary: data)
//                })
//            }) {
//                self.labInfo = labInfo
//                completion(.success)
//            } else {
//                completion(.failure("ERR Lab Info does not exist"))
//            }
        }
    }
    
    func updateLabInfo(byId labId: String, withNewName newName: String, newDescription: String, completion: @escaping FetchFirestoreHandler) {
        // update lab's name and description
        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").document(labId).setData([
            "labName": newName,
            "description": newDescription
        ]) { err in
            if let err = err {
                completion(.failure(err.localizedDescription + "ERR fail to update Lab Info"))
            } else {
                print("Successfully update Equipment using!")
                completion(.success)
            }
        }
    }
    
    func createLab(withName labName: String, description: String, completion: @escaping CreateFirestoreHandler) {
        let newLab = Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6")
            .collection("labs").document()
        newLab.setData([
            "labName": labName,
            "description": description
        ]) { err in
            if let err = err {
                completion(.failure("ERR creating a new Lab \(err)"))
            } else {
                completion(.success(newLab.documentID))
            }
        }
//         Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6")
//            .collection("labs").addDocument(data: [
//                "labName" : labName,
//                "description": description
//            ]) { err in
//                if let err = err {
//                    completion(.failure("ERR creating a new Lab \(err)"))
//                } else {
//                    completion(.success)
//                }
//        }
//    }
    }
}
