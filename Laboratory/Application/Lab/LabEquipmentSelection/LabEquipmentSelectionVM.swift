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
    
    let addedSectionHeader = "Added Equipment"
    let availableSectionHeader = "Available Equipment"
    
    // "all" keep a copy of everything before the search
    var allAddedEquipmentVMs: [LabEquipmentVM]?
    var allAvailableEquipmentVMs: [SimpleEquipmentVM]?
    
    // "displaying" is for displaying with and without search
    var displayingAddedEquipmentVMs: [LabEquipmentVM]?
    var displayingAvailableEquipmentVMs: [SimpleEquipmentVM]?
    
    lazy var searchText = ""
    
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
                        self.assignEquipmentViewModels(withAddedEquipmentViewModels: addedEquipmentVMs, allEquipmentViewModels: allEquipmentVMs)
                        
                        completion(.success)
                    }
                })
            }
        }
    }
    
    private func assignEquipmentViewModels(withAddedEquipmentViewModels addedEquipmentViewModels: [LabEquipmentVM], allEquipmentViewModels: [SimpleEquipmentVM]) {
        self.allAddedEquipmentVMs = addedEquipmentViewModels
        self.displayingAddedEquipmentVMs = addedEquipmentViewModels
        
        // convert addedEquipmentVMs to addedSimpleEquipmentVMs to do the subtraction
        let addedSimpleEquipmentVMs = addedEquipmentViewModels.map({
            SimpleEquipmentVM(equipment: Equipment(id: $0.equipmentId, name: $0.equipmentName))
        })
        
        // available = all - added
        let availableEquipmentVMs = allEquipmentViewModels.filter({
            !addedSimpleEquipmentVMs.contains($0)
        })
        
        self.allAvailableEquipmentVMs = availableEquipmentVMs
        self.displayingAvailableEquipmentVMs = availableEquipmentVMs
    }
    
    func doSearch() {
        if searchText == "" {
            clearFilter()
        } else {
            filterViewModels()
        }
    }
    
    private func clearFilter() {
        displayingAddedEquipmentVMs = allAddedEquipmentVMs
        displayingAvailableEquipmentVMs = allAvailableEquipmentVMs
    }
    
    private func filterViewModels() {
        displayingAddedEquipmentVMs = allAddedEquipmentVMs?.filter({ $0.equipmentName.lowercased().contains(searchText.lowercased())
        })
        
        displayingAvailableEquipmentVMs = allAvailableEquipmentVMs?.filter({ $0.equipmentName.lowercased().contains(searchText.lowercased())
        })
    }
}
