//
//  LabEquipmentSelectionVM.swift
//  Laboratory
//
//  Created by Developers on 5/22/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

class LabEquipmentSelectionVM {
    
    let addedSectionHeader = "Added Equipments"
    let availableSectionHeader = "Available Equipments"
    
    // "all" keep a copy of everything before the search
    var allAddedEquipmentVMs: [LabEquipmentVM]?
    var allAvailableEquipmentVMs: [SimpleEquipmentVM]?
    
    // "displaying" is for displaying with and without search
    var displayingAddedEquipmentVMs: [LabEquipmentVM]?
    var displayingAvailableEquipmentVMs: [SimpleEquipmentVM]?
    
    func fetchEquipments(byLabId labId: String, completion: @escaping FetchHandler) {
        FirestoreSvc.fetchLabEquipments(byLabId: labId) { [unowned self] (fetchLabEquipmentResult) in
            switch fetchLabEquipmentResult {
            case let .success(addedEquipments):
                let addedEquipmentVMs = addedEquipments.map({ LabEquipmentVM(equipment: $0) })
                self.fetchAllEquipments(addedEquipmentVMs: addedEquipmentVMs,
                                        completion: { completion($0) })
            case let .failure(errorStr):
                completion(.failure(errorStr))
            }
        }
//        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6")
//            .collection("labs").document(labName).collection("equipments").getDocuments { [unowned self] (snapshot, error) in
//                if error != nil { completion(.failure(error?.localizedDescription ?? "ERR fetching Lab Equipments data"))
//                } else {
//                    var addedEquipmentVMs = [LabEquipmentVM]()
//                    for document in (snapshot!.documents) {
//                        if let equipmentName = document.data()["equipmentName"] as? String,
//                            let using = document.data()["using"] as? Int {
//                            addedEquipmentVMs.append(LabEquipmentVM(equipment: LabEquipment(name: equipmentName, using: using)))
//                        }
//                    }
//                    self.fetchAllEquipments(addedEquipmentVMs: addedEquipmentVMs, completion: { completion($0)
//                    })
//                }
//        }
    }
    
    // TODO: maybe i can reuse fetchAllEquipments from EquipmentListVM instead of this?
    func fetchAllEquipments(addedEquipmentVMs: [LabEquipmentVM], completion: @escaping FetchHandler) {
        Firestore.firestore().collection("institutions").document("MXnWedK2McfuhBpVr3WQ").collection("items").order(by: "name", descending: false).getDocuments { [unowned self] (snapshot, error) in
            if error != nil { completion(.failure(error?.localizedDescription ?? "ERR fetching Equipments data"))
            } else {
                var equipmentVMs = [SimpleEquipmentVM]()
                for document in (snapshot!.documents) {
                    if let equipmentName = document.data()["name"] as? String
                    { equipmentVMs.append(SimpleEquipmentVM(equipment: Equipment(name: equipmentName)))
                    }
                }
                // assign addedEquipmentVMs to both all and displaying
                self.allAddedEquipmentVMs = addedEquipmentVMs
                self.displayingAddedEquipmentVMs = addedEquipmentVMs
                
                // convert addedEquipmentVMs to addedSimpleEquipmentVMs to do the subtraction
                let addedSimpleEquipmentVMs = addedEquipmentVMs.map({ SimpleEquipmentVM(equipment: Equipment(name: $0.equipmentName)) })
                // available = all - added
                let availableEquipmentVMs = equipmentVMs.filter({ !addedSimpleEquipmentVMs.contains($0) })
                // assign availableEquipmentVMs to both all and displaying
                self.allAvailableEquipmentVMs = availableEquipmentVMs
                self.displayingAvailableEquipmentVMs = availableEquipmentVMs
                completion(.success)
            }
        }
    }
    
    func search(by text: String) {
        if text == "" {
            // show all when search text is empty
            displayingAddedEquipmentVMs = allAddedEquipmentVMs
            displayingAvailableEquipmentVMs = allAvailableEquipmentVMs
        } else {
            displayingAddedEquipmentVMs = allAddedEquipmentVMs?.filter({ $0.equipmentName.lowercased().contains(text.lowercased())
            })
            
            displayingAvailableEquipmentVMs = allAvailableEquipmentVMs?.filter({ $0.equipmentName.lowercased().contains(text.lowercased())
            })
        }
    }
}
