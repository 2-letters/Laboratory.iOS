//
//  LabInfoVM.swift
//  Laboratory
//
//  Created by Developers on 5/21/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

class LabInfoVM {
    var labInfo: LabInfo
    var accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator
    
    init(_ labInfo: LabInfo) {
        self.labInfo = labInfo
    }
    
    func loadLabEquipments() {
//        guard let labName = labInfo.name else {
//            return
//        }
        LabSvc.fetchLabEquipment(byName: labInfo.name) { [unowned self] (labEquipmentResult) in
            switch labEquipmentResult {
            case let .failure(errorStr):
                print(errorStr)
            case let .success(equipments):
                self.labInfo.equipments = equipments
                // successfully fetch lab equipments data, reload the table view
                
                self.labEquipmentTableView?.reloadData()
            }
        }
    }
}
