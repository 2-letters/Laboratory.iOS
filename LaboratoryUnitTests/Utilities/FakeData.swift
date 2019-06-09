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
    static var simpleEquipmentVM: SimpleEquipmentVM {
        return SimpleEquipmentVM(equipment: Equipment(name: "fakeName"))
    }
    static var labEquipmentVM: LabEquipmentVM {
        return LabEquipmentVM(equipment: LabEquipment(name: "fakeEquipment", using: 2))
    }
}
