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
    
    func fetchEquipments(byLabId labId: String, completion: @escaping FetchFirestoreHandler) {
        FirestoreSvc.fetchLabEquipments(byLabId: labId) { [weak self] (fetchLabEquipmentResult) in
            guard let self = self else { return }
            switch fetchLabEquipmentResult {
                
            case let .failure(errorStr):
                completion(.failure(errorStr))
                
            case let .success(addedEquipments):
                let addedEquipmentVMs = addedEquipments.map({ LabEquipmentVM(equipment: $0) })
                FirestoreSvc.fetchAllEquipments(completion: { (fetchResult) in
                    switch fetchResult {
                        
                    case let .failure(errorStr):
                        completion(.failure(errorStr))
                        
                    case let .success(allEquipmentVMs):
                        // assign addedEquipmentVMs to both all and displaying
                        self.allAddedEquipmentVMs = addedEquipmentVMs
                        self.displayingAddedEquipmentVMs = addedEquipmentVMs
                        
                        // convert addedEquipmentVMs to addedSimpleEquipmentVMs to do the subtraction
                        let addedSimpleEquipmentVMs = addedEquipmentVMs.map({
                            SimpleEquipmentVM(equipment: Equipment(name: $0.equipmentName))
                        })
                        
                        // available = all - added
                        let availableEquipmentVMs = allEquipmentVMs.filter({
                            !addedSimpleEquipmentVMs.contains($0)
                        })
                        
                        // assign availableEquipmentVMs to both all and displaying
                        self.allAvailableEquipmentVMs = availableEquipmentVMs
                        self.displayingAvailableEquipmentVMs = availableEquipmentVMs
                        
                        completion(.success)
                    }
                })
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
