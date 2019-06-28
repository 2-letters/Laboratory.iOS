//
//  EquipmentUserListVM.swift
//  Laboratory
//
//  Created by Developers on 6/28/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

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
    
    func getUsers(forEquipmentId equipmentId: String, completion: @escaping FetchFirestoreHandler) {
        // empty the aray before appending
        equipmentUserVMs = []
        
        FirestoreUtil.getEquipment(withId: equipmentId).collection(EquipmentKey.users).getDocuments { [weak self] (snapshot, error) in
            guard let self = self else { return }
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Equipment Users data"))
            } else {
                for document in (snapshot!.documents) {
                    if let userName = document.data()[EquipmentKey.userName] as? String,
                        let using = document.data()[EquipmentKey.using] as? Int
                    {
                        self.equipmentUserVMs?.append(EquipmentUserVM(equipmentUser:
                            EquipmentUser(userName: userName, using: using)))
                    }
                }
                completion(.success)
            }
        }
    }
}
