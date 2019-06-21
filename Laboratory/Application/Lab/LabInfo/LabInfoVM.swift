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
        .getDocument { [weak self] (document, error) in
            guard let self = self else { return }
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
        }
    }
    
    func saveLab(withNewName newName: String, newDescription: String, labId: String? = nil, completion: @escaping UpdateFirestoreHandler) {
        if let labId = labId {
            // Update existed lab
            Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").document(labId).updateData([
                "labName": newName,
                "description": newDescription
            ]) { err in
                if let err = err {
                    completion(.failure(err.localizedDescription + "ERR fail to update Lab Info"))
                } else {
                    print("Successfully update lab with id: \(labId)")
                    completion(.success(nil))
                }
            }
        } else {
            // Create a new lab
            let newLab = Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6")
                .collection("labs").document()
            newLab.setData([
                "labName": newName,
                "description": newDescription
            ]) { err in
                if let err = err {
                    completion(.failure("ERR creating a new Lab \(err)"))
                } else {
                    completion(.success(newLab.documentID))
                }
            }
        }
    }
    
    func removeLab(withId labId: String?, completion: @escaping DeleteFirestoreHandler) {
        guard let labId = labId else {
            completion(.failure("ERR could not find Lab Id"))
            return
        }
        
        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").document(labId).delete() { err in
            if let err = err {
                completion(.failure("Error removing document: \(err)"))
            } else {
                completion(.success)
            }
        }

    }
}
