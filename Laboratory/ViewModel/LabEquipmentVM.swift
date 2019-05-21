//
//  LabEquipmentVM.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

struct LabEquipmentVM {
    var equipmentName: String
    var quantity: Int
    var accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator
    
    init(_ equipment: LabEquipment) {
        self.equipmentName = equipment.name
        self.quantity = equipment.quantity
    }
    
    func loadLabEquipments() {
        guard let labName = labVM?.labName else {
            return
        }
        LabSvc.fetchLabEquipment(byName: labName) { [unowned self] (labEquipmentResult) in
            switch labEquipmentResult {
            case let .failure(errorStr):
                print(errorStr)
            case let .success(viewModels):
                self.labEquipmentVMs = viewModels
                // successfully fetch lab equipments data, reload the table view
                self.labEquipmentTableView?.reloadData()
            }
        }
    }
}
