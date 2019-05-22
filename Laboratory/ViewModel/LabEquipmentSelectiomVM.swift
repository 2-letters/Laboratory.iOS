//
//  LabEquipmentSelectiomVM.swift
//  Laboratory
//
//  Created by Developers on 5/22/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

class LabEquipmentSelectionVM {
    var addedEquipmentVMs: [SimpleEquipmentVM]?
    var availableEquipmentVMs: [SimpleEquipmentVM]?
    
//    init(addedEquipments: [String], allEquipments: [String]) {
//        self.addedEquipments = addedEquipments
//        availableEquipments = allEquipments.filter({ !addedEquipments.contains($0) })
//    }
    
    func fetchEquipments(addedEquipments: [String], completion: () -> ()) {
        EquipmentSvc.fetchAllEquipments { [unowned self] (allEquipmentResult) in
            switch allEquipmentResult {
            case let .success(allEquipments):
                self.addedEquipmentVMs = addedEquipments.map({ SimpleEquipmentVM(equipment: Equipment(name: $0)) })
//                let allEquipmentNames = allEquipments
                self.availableEquipmentVMs = allEquipments.filter({ !self.addedEquipmentVMs!.contains($0) })
            // TODO: save to cache
            case let .failure(error):
                print(error)
            }
        }
    }
}
