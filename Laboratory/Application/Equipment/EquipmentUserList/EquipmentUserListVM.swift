//
//  EquipmentUserListVM.swift
//  Laboratory
//
//  Created by Developers on 6/28/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct EquipmentUserVM {
    var equipmentUser: EquipmentUser!
    var userName: String {
        return equipmentUser.userName
    }
    var usingString: String {
        return "Using: \(equipmentUser.using)"
    }
}

class EquipmentUserListVM {
    var equipmentUserVMs: [EquipmentUserVM]?
    let reuseId = "EquipmentUserCell"
    
    func getUsers(forEquipmentId equipmentId: String?, completion: @escaping FetchFirestoreHandler) {
        guard let equipmentId = equipmentId else {
            completion(.failure("ERR could not find Lab Id"))
            return
        }
        
        FirestoreUtil.fetchEquipment(withId: equipmentId).collection(EquipmentKey.users).getDocuments { [weak self] (snapshot, error) in
            guard let self = self else { return }
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Equipment Users data"))
            } else {
                self.assignEquipmentUserViewModels(withSnapshot: snapshot!)
                completion(.success)
            }
        }
    }
    
    private func assignEquipmentUserViewModels(withSnapshot snapshot: QuerySnapshot) {
        // empty the aray before appending
        equipmentUserVMs = []
        
        for document in (snapshot.documents) {
            if let userName = document.data()[EquipmentKey.userName] as? String,
                let using = document.data()[EquipmentKey.using] as? Int
            {
                equipmentUserVMs?.append(EquipmentUserVM(equipmentUser:
                    EquipmentUser(userName: userName, using: using)))
            }
        }
    }
}
