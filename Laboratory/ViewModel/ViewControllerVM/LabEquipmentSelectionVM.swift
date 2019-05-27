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
    
    // TODO: maybe i can reuse fetchAllEquipments from EquipmentListVM instead of this?
    func fetchEquipments(addedEquipmentVMs: [LabEquipmentVM], completion: @escaping FetchHandler) {
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
        displayingAddedEquipmentVMs = allAddedEquipmentVMs?.filter({ $0.equipmentName.lowercased().contains(text.lowercased())
        })
        
        displayingAvailableEquipmentVMs = allAvailableEquipmentVMs?.filter({ $0.equipmentName.lowercased().contains(text.lowercased())
        })
    }
}
