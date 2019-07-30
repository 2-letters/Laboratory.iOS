//
//  EquipmentInfoVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

import Foundation

class EquipmentInfoVM: NSObject {
//    let cache = NSCache<NSString, FullEquipment>()
    var equipment: FullEquipment?
//    var equipmentName: String { return equipment!.name }
//    var availableString: String { return String(equipment!.available) }
//    var description: String { return equipment!.description }
//    var location: String { return equipment!.location }
    
    var equipmentName: Dynamic<String> = Dynamic(String())
    var availableString: Dynamic<String> = Dynamic(String())
    var equipmentDescription: Dynamic<String> = Dynamic(String())
    var location: Dynamic<String> = Dynamic(String())
    
    var imageUrl: Dynamic<String> = Dynamic(String())
    
    func setUrl(forImage image: UIImage) {
        // TODO get image url
        imageUrl.value = "https://i.imgur.com/0ISKm8z.jpg"
    }
    
    func fetchEquipmentInfo(byId equipmentId: String?, completion: @escaping FetchFirestoreHandler) {
        // TODO: get department and instituion from Cache?
        guard let equipmentId = equipmentId else {
            completion(.failure("ERR could not load Lab Id"))
            return
        }
        // Check the cache
        
        let equipmentKey = "Equipment.\(equipmentId)" as NSString
        if let cachedEquipment = MyCache.shared.object(forKey: equipmentKey) {
            equipment = (cachedEquipment as! FullEquipment)
            self.assignEquipmentInfo()
            completion(.success)
            return
        }
        
        // Else get from Firestore
        FirestoreUtil.fetchEquipment(withId: equipmentId).getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            let key = EquipmentKey.self
            if let document = document, document.exists {
                let docData = document.data()!
                let equipmentName = docData[key.name] as! String
                let quantity = docData[key.available] as! Int
                let description = docData[key.description] as! String
                let location = docData[key.location] as! String
                let imageUrl = docData[key.imageUrl] as! String
                let equipment = FullEquipment(name: equipmentName, available: quantity, description: description, location: location, imageUrl: imageUrl)
                self.equipment = equipment
                self.assignEquipmentInfo()
                
                // Cache it
                MyCache.shared.setObject(equipment, forKey: equipmentKey)
                completion(.success)
                
            } else {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Equipment Info data"))
            }
        }
    }
    
    private func assignEquipmentInfo() {
        equipmentName.value = equipment!.name
        availableString.value = String(equipment!.available)
        equipmentDescription.value = equipment!.description
        location.value = equipment!.location
        imageUrl.value = equipment!.imageUrl
    }
    
    func saveEquipment(withId equipmentId: String? = nil, completion: @escaping UpdateFirestoreHandler) {
        if let equipmentId = equipmentId {
            // Update existed equipment
            FirestoreUtil.fetchEquipment(withId: equipmentId).updateData([
                EquipmentKey.name: equipmentName.value,
                EquipmentKey.description: equipmentDescription.value,
                EquipmentKey.location: location.value,
                EquipmentKey.imageUrl: imageUrl,
                EquipmentKey.available: availableString.value
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
            let newEquipment = FirestoreUtil.fetchAllEquipments().document()
            newEquipment.setData([
                EquipmentKey.name: equipmentName.value,
                EquipmentKey.description: equipmentDescription.value,
                EquipmentKey.location: location.value,
                EquipmentKey.imageUrl: imageUrl,
                EquipmentKey.available: availableString.value
            ]) { err in
                if let err = err {
                    completion(.failure("voxERR creating a new Equipment \(err)"))
                } else {
                    completion(.success(nil))
                }
            }
        }
    }
    
    func deleteEquipment(withId equipmentId: String?, completion: @escaping DeleteFirestoreHandler) {
        guard let equipmentId = equipmentId else {
            completion(.failure("ERR could not find Lab Id"))
            return
        }
        
        FirestoreUtil.fetchEquipment(withId: equipmentId).delete() { err in
            if let err = err {
                completion(.failure("Error removing document: \(err)"))
            } else {
                completion(.success)
            }
        }
    }
}
