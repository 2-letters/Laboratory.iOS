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
    static let userId = "unitTestUser1"
    static let wrongUserId = "neverCreatedUser"
    static let institutionId = "unitTestInstitution"
    static let wrongInstitutionId = "neverCreatedInstitution"
    
    static let labId = "unitTestLab1"
    static let labName = "fake Lab Name"
    static let newLabNameSave = "Unit Test Lab 1"
    static let newLabNameCreate = "Delete me when you are free"
    static let newLabDescriptionSave = "Hello I am not gay"
    static let newLabDescriptionCreate = "Please delete meeeeeee. Dont even ask"
    
    static let equipmentId = "unitTestEquipment1"
    static let equipmentName = "Unit Test Equipment Name 1"
    static let equipmentDescription = "Please delete meeeeeee. Dont even ask"
    
    // MARK: - Models
    // MARK: Lab
    static var labInfo: LabInfo {
        return LabInfo(name: "fake Lab Name", description: "fake Description", equipments: [FakeData.labEquipment1, FakeData.labEquipment2, FakeData.labEquipment3])
    }
    
    static var labEquipment1: LabEquipment {
        return LabEquipment(id: "fakeEquipment1", name: "fake fake Equipment", using: 2)
    }
    
    static var labEquipment2: LabEquipment {
        return LabEquipment(id: "fakeEquipment2", name: "super real Equipment", using: 3)
    }
    
    static var labEquipment3: LabEquipment {
        return LabEquipment(id: "fakeEquipment3", name: "real fake Equipment", using: 4)
    }
    
    // MARK: Equipment
    static var fullEquipment: FullEquipment {
        return FullEquipment(name: "fake Equipment Name", available: 2, description: "fake Description", location: "fake Location", imageUrl: "https://fakeUrl.jpg")
    }
    
    
    // MARK: - View Models
    // MARK: Lab
    static var labInfoVM: LabInfoVM {
        let labInfoVM = LabInfoVM()
        labInfoVM.labInfo = FakeData.labInfo
        return LabInfoVM()
    }
    
    static var labEquipmentVM: LabEquipmentVM {
        return LabEquipmentVM(equipment: LabEquipment(id: "fakeEquipmentId", name: "fake Equipment Name", using: 2))
    }
    static var labEquipmentVMs: [LabEquipmentVM] {
        return [LabEquipmentVM(equipment: FakeData.labEquipment1),
                LabEquipmentVM(equipment: FakeData.labEquipment2),
                LabEquipmentVM(equipment: FakeData.labEquipment3)]
    }
    
    static var labCellVM: LabCellVM {
        return LabCellVM(lab: Lab(id: "fakeLabId", name: "fake Lab Name", description: "fake Description"))
    }
    static var LabCellVMs: [LabCellVM] {
        return [LabCellVM(lab: Lab(id: "fakeLab1", name: "fake fake Name", description: "fake Description 1")),
                LabCellVM(lab: Lab(id: "fakeLab2", name: "super real Name", description: "fake Description 2")),
                LabCellVM(lab: Lab(id: "fakeLab3", name: "real fake Name", description: "fake Description 3"))]
    }
    
    // MARK: Equipment
    static var simpleEquipmentVM: SimpleEquipmentVM {
        return SimpleEquipmentVM(equipment: Equipment(id: "fakeEquipmentId", name: "fake Equipment Name"))
    }
    static var simpleEquipmentVMs: [SimpleEquipmentVM] {
        return [SimpleEquipmentVM(equipment: Equipment(id: "fakeEquipmentId", name: "fake fake Equipment")),
                SimpleEquipmentVM(equipment: Equipment(id: "fakeEquipmentId", name: "super real Equipment")),
                SimpleEquipmentVM(equipment: Equipment(id: "fakeEquipmentId", name: "real fake Equipment"))]
    }
    
    
}
