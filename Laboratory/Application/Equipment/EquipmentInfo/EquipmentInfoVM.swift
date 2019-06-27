//
//  EquipmentInfoVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

class EquipmentInfoVM {
//    let firestoreUtil = FirestoreUtil.shared
    var equipment: FullEquipment?
    var equipmentName: String {
        return equipment!.name
    }
    var availableString: String {
        return String(equipment!.available)
    }
//    var available: Int {
//        return equipment?.available ?? 0
//    }
    var description: String {
        return equipment!.description
    }
    var location: String {
        return equipment!.location
    }
    var imageUrl: String {
        return equipment!.imageUrl
    }
    
    func getUrl(forImage image: UIImage) -> String {
        // TODO get image url
        return imageUrl
    }
    
    func fetchEquipmentInfo(byId equipmentId: String?, completion: @escaping FetchFirestoreHandler) {
        // TODO: get department and instituion from Cache?
        guard let equipmentId = equipmentId else {
            completion(.failure("ERR could not load Lab Id"))
            return
        }
        FirestoreUtil.getEquipment(withId: equipmentId).getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            let key = EquipmentKey.self
            if let document = document, document.exists {
                let docData = document.data()!
                let equipmentName = docData[key.name] as! String
                let quantity = docData[key.available] as! Int
                let description = docData[key.description] as! String
                let location = docData[key.location] as! String
                let imageUrl = docData[key.imageUrl] as! String
                self.equipment = FullEquipment(name: equipmentName, available: quantity, description: description, location: location, imageUrl: imageUrl)
                    completion(.success)
            } else {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Equipment Info data"))
            }
        }
    }
    
    func saveEquipment(withNewName newName: String, newDescription: String, newLocation: String, newImageUrl: String, newAvailable: Int, equipmentId: String? = nil, completion: @escaping UpdateFirestoreHandler) {
        if let equipmentId = equipmentId {
            // Update existed equipment
            FirestoreUtil.getEquipment(withId: equipmentId).updateData([
                EquipmentKey.name: newName,
                EquipmentKey.description: newDescription,
                EquipmentKey.location: newLocation,
                EquipmentKey.imageUrl: newImageUrl,
                EquipmentKey.available: newAvailable
            ]) { err in
                if let err = err {
                    completion(.failure(err.localizedDescription + "voxERR fail to update Equipment Info"))
                } else {
                    print("Successfully update lab with id: \(equipmentId)")
                    completion(.success(nil))
                }
            }
        } else {
            // Create a new Equipment
            let newEquipment = FirestoreUtil.getAllEquipments().document()
            newEquipment.setData([
                EquipmentKey.name: newName,
                EquipmentKey.description: newDescription,
                EquipmentKey.location: newLocation,
                EquipmentKey.imageUrl: newImageUrl,
                EquipmentKey.available: newAvailable
            ]) { err in
                if let err = err {
                    completion(.failure("voxERR creating a new Equipment \(err)"))
                } else {
                    completion(.success(nil))
                }
            }
        }
    }
}
