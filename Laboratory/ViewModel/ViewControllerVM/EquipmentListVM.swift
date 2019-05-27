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
    
    func fetchAllEquipments(completion: @escaping FetchHandler) {
        Firestore.firestore().collection("institutions").document("MXnWedK2McfuhBpVr3WQ").collection("items").order(by: "name", descending: false).getDocuments { [unowned self] (snapshot, error) in
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Equipments data"))
            } else {
                var equipmentVMs = [SimpleEquipmentVM]()
                for document in (snapshot!.documents) {
                    if let equipmentName = document.data()["name"] as? String
                    { equipmentVMs.append(SimpleEquipmentVM(equipment: Equipment(name: equipmentName)))
                    }
                }
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
