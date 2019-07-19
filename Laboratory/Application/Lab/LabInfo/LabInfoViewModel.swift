//
//  LabInfoViewModel.swift
//  Laboratory
//
//  Created by Developers on 5/21/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore


class LabInfoViewModel {
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
        
        // Check cache
        let labInfoKey = "Lab\(labId)" as NSString
        if let labInfo = MyCache.shared.object(forKey: labInfoKey) {
            self.labInfo = (labInfo as! LabInfo)
            completion(.success)
            return
        }
        
        FirestoreUtil.getLab(withId: labId).getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            if let document = document, document.exists {
                let labName = document.data()![LabKey.name] as! String
                let description = document.data()![LabKey.description] as! String
                FirestoreSvc.fetchLabEquipments(byLabId: labId, completion: { (fetchLabEquipmentResult) in
                    switch fetchLabEquipmentResult {
                    case let .success(labEquipments):
                        let labInfo = LabInfo(name: labName, description: description, equipments: labEquipments)
                        self.labInfo = labInfo
                        // cache labInfo
                        MyCache.shared.setObject(labInfo, forKey: labInfoKey)
                        completion(.success)
                        
                    case let .failure(errorStr):
                        completion(.failure(errorStr))
                    }
                })
            } else {
                completion(.failure(error?.localizedDescription ?? "voxERR fetching Lab Info"))
            }
        }
    }
    
    func saveLab(withNewName newName: String, newDescription: String, labId: String? = nil, completion: @escaping UpdateFirestoreHandler) {
        if let labId = labId {
            // Update existed lab
            FirestoreUtil.getLab(withId: labId).updateData([
                LabKey.name: newName,
                LabKey.description: newDescription
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
            let newLab = FirestoreUtil.getLabs().document()
            newLab.setData([
                LabKey.name: newName,
                LabKey.description: newDescription
            ]) { err in
                if let err = err {
                    completion(.failure("ERR creating a new Lab \(err)"))
                } else {
                    completion(.success(newLab.documentID))
                }
            }
        }
    }
    
    func deleteLab(withId labId: String?, completion: @escaping DeleteFirestoreHandler) {
        guard let labId = labId else {
            completion(.failure("ERR could not find Lab Id"))
            return
        }
        
        FirestoreUtil.getLab(withId: labId).delete() { err in
            if let err = err {
                completion(.failure("Error removing document: \(err)"))
            } else {
                completion(.success)
            }
        }
    }
}
