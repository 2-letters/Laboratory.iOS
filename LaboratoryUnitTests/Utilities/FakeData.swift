//
//  FakeData.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
@testable import Laboratory

struct FakeData {
    static let labId = "fakeLab"
    static let equipmentId = "fakeEquipment"
    static let equipmentName = "fake Equipment Name"
    
    static var simpleEquipmentVM: SimpleEquipmentVM {
        return SimpleEquipmentVM(equipment: Equipment(name: "fake Equipment Name"))
    }
    static var simpleEquipmentVMs: [SimpleEquipmentVM] {
        return [SimpleEquipmentVM(equipment: Equipment(name: "fake fake Equipment")),
                SimpleEquipmentVM(equipment: Equipment(name: "super real Equipment")),
                SimpleEquipmentVM(equipment: Equipment(name: "real fake Equipment"))]
    }
    
    static var labEquipmentVM: LabEquipmentVM {
        return LabEquipmentVM(equipment: LabEquipment(name: "fake Equipment Name", using: 2))
    }
    static var labEquipmentVMs: [LabEquipmentVM] {
        return [LabEquipmentVM(equipment: LabEquipment(name: "fake fake Equipment", using: 2)),
                LabEquipmentVM(equipment: LabEquipment(name: "super real Equipment", using: 3)),
                LabEquipmentVM(equipment: LabEquipment(name: "real fake Equipment", using: 4))]
    }
    
    static var labCellVM: LabCellVM {
        return LabCellVM(lab: Lab(id: "fakeLab", name: "fake Lab Name", description: "fake Description"))
    }
    static var LabCellVMs: [LabCellVM] {
        return [LabCellVM(lab: Lab(id: "fakeLab1", name: "fake fake Name", description: "fake Description 1")),
                LabCellVM(lab: Lab(id: "fakeLab2", name: "super real Name", description: "fake Description 2")),
                LabCellVM(lab: Lab(id: "fakeLab3", name: "real fake Name", description: "fake Description 3"))]
    }
    
    static var fullEquipment: FullEquipment {
        return FullEquipment(name: "fake Equipment Name", available: 2, description: "fake Description", location: "fake Location", pictureUrl: "https://fakeUrl.jpg")
    }
}
