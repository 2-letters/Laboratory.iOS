//
//  LabEquipmentVM.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

struct LabEquipmentVM {
    let labEquipment: LabEquipment
    
    init(equipment: LabEquipment) {
        self.labEquipment = equipment
    }
    
    var equipmentName: String { return labEquipment.name }
    var quantityString: String {
        return "Quantity: \(labEquipment.quantity)"
    }
    var quantity: Int {
        return labEquipment.quantity
    }
    
    
    
//    func loadLabEquipments() {
//        guard let labName = labVM?.labName else {
//            return
//        }
//        LabSvc.fetchLabEquipment(byName: labName) { [unowned self] (labEquipmentResult) in
//            switch labEquipmentResult {
//            case let .failure(errorStr):
//                print(errorStr)
//            case let .success(viewModel):
//                self.labEquipmentVMs = viewModels
//                // successfully fetch lab equipments data, reload the table view
//                self.labEquipmentTableView?.reloadData()
//            }
//        }
//    }
}
