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
//    var labInfoCacheKey: NSString?
    
    var labId: String?
    var labName: String {
        get { return labInfo!.name }
        set { labInfo!.name = newValue }
    }
    var description: String {
        get { return labInfo!.description }
        set { labInfo!.description = newValue }
    }
    var equipmentVMs: [LabEquipmentVM]? {
        return labInfo?.equipments.map({ LabEquipmentVM(equipment: $0) })
    }
    
    func setupLabInfo(withLabName labName: String, description: String) {
        labInfo = LabInfo(name: labName, description: description)
    }
    
    func fetchLabInfo(completion: @escaping FetchFirestoreHandler) {
        guard let labId = labId else { return }
        
        // Check cache
//        labInfoCacheKey = "Lab\(labId)" as NSString
//        if isFetchingLabInfoFromCache(withLabId: labId) {
//            completion(.success)
//            return
//        }
        
        FirestoreUtil.fetchLab(withId: labId).getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            
            if let document = document, document.exists {
                FirestoreSvc.fetchLabEquipments(byLabId: labId, completion: { (fetchResult) in
                    switch fetchResult {
                    case let .success(labEquipments):
                        self.handleSucceedFetchingLabInfo(withDocument: document, equipments: labEquipments)
                        
                        completion(.success)
                        
                    case let .failure(errorStr):
                        completion(.failure(errorStr))
                    }
                })
            } else {
                completion(.failure(error?.localizedDescription ?? "voxERR fetch Lab Info"))
            }
        }
    }
    
//    private func isFetchingLabInfoFromCache(withLabId labId: String) -> Bool {
//        if let labInfo = MyCache.shared.object(forKey: labInfoCacheKey!) {
//            self.labInfo = (labInfo as! LabInfo)
//            return true
//        }
//        return false
//    }
    
    private func handleSucceedFetchingLabInfo(withDocument document: DocumentSnapshot, equipments: [LabEquipment]) {
        let labName = document.data()![LabKey.name] as! String
        let description = document.data()![LabKey.description] as! String
        
        let labInfo = LabInfo(name: labName, description: description, equipments: equipments)
        self.labInfo = labInfo
        
//        MyCache.shared.setObject(labInfo, forKey: self.labInfoCacheKey!)
    }
    
    
    func saveLab(completion: @escaping UpdateFirestoreHandler) {
        if let labId = labId {
            // Update existed lab
            FirestoreUtil.fetchLab(withId: labId).updateData([
                LabKey.name: labName,
                LabKey.description: description
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
            let newLab = FirestoreUtil.fetchLabs().document()
            newLab.setData([
                LabKey.name: labName,
                LabKey.description: description
            ]) { err in
                if let err = err {
                    completion(.failure("ERR creating a new Lab \(err)"))
                } else {
                    completion(.success(newLab.documentID))
                }
            }
        }
    }
    
    func deleteLab(withId labId: String, completion: @escaping DeleteFirestoreHandler) {
        FirestoreUtil.fetchLab(withId: labId).delete() { err in
            if let err = err {
                completion(.failure("Error removing document: \(err)"))
            } else {
                completion(.success)
            }
        }
    }
}
