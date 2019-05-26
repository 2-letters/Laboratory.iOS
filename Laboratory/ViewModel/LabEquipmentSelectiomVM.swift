//
//  LabEquipmentSelectiomVM.swift
//  Laboratory
//
//  Created by Developers on 5/22/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

class LabEquipmentSelectionVM {
    
    let addedSectionHeader = "Added Equipments"
    let availableSectionHeader = "Available Equipments"
    
    // "all" keep a copy of everything before the search
    var allAddedEquipmentVMs: [LabEquipmentVM]?
    var allAvailableEquipmentVMs: [SimpleEquipmentVM]?
    
    // "displaying" is for displaying with and without search
    var displayingAddedEquipmentVMs: [LabEquipmentVM]?
    var displayingAvailableEquipmentVMs: [SimpleEquipmentVM]?
    
    
    func fetchEquipments(addedEquipmentVMs: [LabEquipmentVM], completion: @escaping (FetchResult) -> ()) {
        EquipmentSvc.fetchAllEquipments { [unowned self] (allEquipmentResult) in
            switch allEquipmentResult {
                
            case let .success(allEquipments):
                // assign addedEquipmentVMs to both all and displaying
                self.allAddedEquipmentVMs = addedEquipmentVMs
                self.displayingAddedEquipmentVMs = addedEquipmentVMs
                
                let addedSimpleEquipmentVMs = addedEquipmentVMs.map({ SimpleEquipmentVM(equipment: Equipment(name: $0.equipmentName)) })
                let availableEquipmentVMs = allEquipments.filter({ !addedSimpleEquipmentVMs.contains($0) })
                // assign availableEquipmentVMs to both all and displaying
                self.allAvailableEquipmentVMs = availableEquipmentVMs
                self.displayingAvailableEquipmentVMs = availableEquipmentVMs
                completion(.success)
            // TODO: save to cache
                
            case let .failure(error):
                print(error)
                completion(.failure)
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
