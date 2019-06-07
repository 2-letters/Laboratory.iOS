//
//  EquipmentListVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/26/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

// For Equipment List ViewController
class EquipmentListVM {
    var allEquipmentVMs: [SimpleEquipmentVM]?
    var displayingEquipmentVMs: [SimpleEquipmentVM]?
    
    func getName(at index: Int) -> String {
        return displayingEquipmentVMs![index].equipmentName
    }
    
    func fetchAllEquipments(completion: @escaping FetchFirestoreHandler) {
        FirestoreSvc.fetchAllEquipments { [weak self] (fetchResult) in
            guard let self = self else { return }
            switch fetchResult {
            case let .failure(errorStr):
                completion(.failure(errorStr))
            case let .success(equipmentVMs):
                self.allEquipmentVMs = equipmentVMs
                self.displayingEquipmentVMs = equipmentVMs
                completion(.success)
            }
        }
    }
    
    func search(by text: String) {
        if text == "" {
            // show all when search text is empty
            displayingEquipmentVMs = allEquipmentVMs
        } else {
            displayingEquipmentVMs = allEquipmentVMs?.filter({
                $0.equipmentName.lowercased().contains(text.lowercased())
            })
        }
    }
}
