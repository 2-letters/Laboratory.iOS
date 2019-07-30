//
//  LabEquipmentEditVM.swift
//  Laboratory
//
//  Created by Developers on 5/28/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum QuantityChange {
    case increase
    case decrease
    case remove
}

class LabEquipmentEditVM: NSObject {
    var equipmentInfoVM = EquipmentInfoVM()
    
    var usingQuantity = 0 {
        didSet {
            editingQuantity.value = usingQuantity
        }
    }
    
    let editingQuantity: Dynamic<Int>
    
    var equipmentName: String {
        return equipmentInfoVM.equipment!.name!
        
    }
    var available: Int {
        return Int(equipmentInfoVM.equipment!.available)
    }
    
    let isDecreaseBtnEnabled: Dynamic<Bool> = Dynamic(false)
    let isIncreaseBtnEnabled: Dynamic<Bool> = Dynamic(false)
    let isRemoveBtnEnabled: Dynamic<Bool> = Dynamic(false)
    // "Save" button is only enable when there's change in quantity
    let isSaveBtnEnabled: Dynamic<Bool> = Dynamic(false)
    
    init(usingQuantity: Int = 0) {
        self.usingQuantity = usingQuantity
        editingQuantity = Dynamic(usingQuantity)
        super.init()
    }
    
    func changeQuantity(by change: QuantityChange) {
        switch change {
        case .increase:
            editingQuantity.value += 1
        case .decrease:
            editingQuantity.value -= 1
        case .remove:
            editingQuantity.value = 0
        }
        
        updateButtonState()
    }
    
    func updateButtonState() {
        isDecreaseBtnEnabled.value = editingQuantity.value != 0
        isIncreaseBtnEnabled.value = editingQuantity.value != available
        isRemoveBtnEnabled.value = editingQuantity.value != 0
        // "Save" button is only enable when there's change in quantity
        isSaveBtnEnabled.value = editingQuantity.value != usingQuantity
    }
    
    func updateEquipmentUsing(forLabId labId: String, equipmentId: String, completion: @escaping UpdateFirestoreHandler) {
        let key = EquipmentKey.self
        // Add a new document in collection "cities"
        FirestoreUtil.fetchLabEquipment(withLabId: labId, equipmentId: equipmentId).setData([
            key.name: equipmentName,
            key.using: editingQuantity.value
        ]) { err in
            if let err = err {
                completion(.failure(err.localizedDescription + "ERR fail to update Equipment using"))
            } else {
                print("Successfully update Equipment using!")
                completion(.success(nil))
            }
        }
    }
    
    func updateQuantityTextField(withText text: String?) {
        var inputedQuantity = Int(text ?? "0") ?? 0
        if inputedQuantity > available {
            inputedQuantity = available
        }
        editingQuantity.value = inputedQuantity
    }
}
