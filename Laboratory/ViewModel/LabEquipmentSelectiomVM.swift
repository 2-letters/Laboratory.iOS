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
    var allAddedEquipmentVMs: [SimpleEquipmentVM]?
    var allAvailableEquipmentVMs: [SimpleEquipmentVM]?
    
    // "displaying" is for displaying with and without search
    var displayingAddedEquipmentVMs: [SimpleEquipmentVM]?
    var displayingAvailableEquipmentVMs: [SimpleEquipmentVM]?
    
    
    func fetchEquipments(addedEquipments: [String], completion: () -> ()) {
        EquipmentSvc.fetchAllEquipments { [unowned self] (allEquipmentResult) in
            switch allEquipmentResult {
                
            case let .success(allEquipments):
                let addedEquipmentVMs = addedEquipments.map({ SimpleEquipmentVM(equipment: Equipment(name: $0)) })
                // assign addedEquipmentVMs to both all and displaying
                self.allAddedEquipmentVMs = addedEquipmentVMs
                self.displayingAddedEquipmentVMs = addedEquipmentVMs
                
                let availableEquipmentVMs = allEquipments.filter({ !self.allAddedEquipmentVMs!.contains($0) })
                // assign availableEquipmentVMs to both all and displaying
                self.allAvailableEquipmentVMs = availableEquipmentVMs
                self.displayingAvailableEquipmentVMs = availableEquipmentVMs
            // TODO: save to cache
                
            case let .failure(error):
                print(error)
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
