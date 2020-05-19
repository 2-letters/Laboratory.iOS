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
            editingQuantity = usingQuantity
        }
    }
    
    var editingQuantity = 0
    
    var equipmentName: String {
        return equipmentInfoVM.equipment!.name
        
    }
    var available: Int {
        return equipmentInfoVM.equipment!.available
    }
    
    var isDecreaseBtnEnabled: Bool {
        return editingQuantity != 0
    }
    var isIncreaseBtnEnabled: Bool {
        return editingQuantity != available
    }
    var isRemoveBtnEnabled: Bool {
        return editingQuantity != 0
    }
    // "Save" button is only enable when there's change in quantity
    var isSaveBtnEnabled: Bool {
        return editingQuantity != usingQuantity
    }
    
    init(usingQuantity: Int = 0) {
        self.usingQuantity = usingQuantity
        editingQuantity = usingQuantity
        super.init()
    }
    
    func changeQuantity(by change: QuantityChange) {
        switch change {
        case .increase:
            editingQuantity += 1
        case .decrease:
            editingQuantity -= 1
        case .remove:
            editingQuantity = 0
        }
    }
    
    func updateEquipmentUsing(forLabId labId: String, equipmentId: String, completion: @escaping UpdateFirestoreHandler) {
        let key = EquipmentKey.self
        // Add a new document in collection "cities"
        FirestoreUtil.fetchLabEquipment(withLabId: labId, equipmentId: equipmentId).setData([
            key.name: equipmentName,
            key.using: editingQuantity
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
        editingQuantity = inputedQuantity
    }
}
