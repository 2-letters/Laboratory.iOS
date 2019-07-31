//
//  EquipmentInfoVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

import CoreData

struct MyCoreDataKey {
    let equipmentName = "equipmentName"
    let equipmentAvailable = "available"
    let equipmentDescription = "equipmentDescription"
    let equipmentLocation = "location"
    let equipmentImageUrl = "imageUrl"
}

class EquipmentInfoVM: NSObject {
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
    
    private let entityName = "FullEquipment"
    private let nameKeyPath = "equipmentName"
    private let available = "available"
    private let descriptionKeyPath = ""
    
    private lazy var coreDataStack = MyCoreData(modelName: "Laboratory")
    private var managedContext: NSManagedObjectContext
    private lazy var coreDataKey = MyCoreDataKey()
    
    override init() {
        managedContext = coreDataStack.managedContext
    }
    
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
        
        // Check Core Data
        
        
        
        // Else get from Firestore
        FirestoreUtil.fetchEquipment(withId: equipmentId).getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            let key = EquipmentKey.self
            if let document = document, document.exists {
                let docData = document.data()!
                let equipmentName = docData[key.name] as! String
                let available = docData[key.available] as! Int
                let description = docData[key.description] as! String
                let location = docData[key.location] as! String
                let imageUrl = docData[key.imageUrl] as! String
//                self.equipment = FullEquipment(name: equipmentName, available: available, description: description, location: location, imageUrl: imageUrl)
                
                
                
                // Save to Core Data
                let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: self.managedContext)!
                
                let equipment = NSManagedObject(entity: entity, insertInto: self.managedContext)
                equipment.setValue(equipmentName, forKey: self.coreDataKey.equipmentName)
                equipment.setValue(available, forKey: self.coreDataKey.equipmentAvailable)
                equipment.setValue(description, forKey: self.coreDataKey.equipmentDescription)
                equipment.setValue(location, forKey: self.coreDataKey.equipmentLocation)
                equipment.setValue(imageUrl, forKey: self.coreDataKey.equipmentDescription)
                
                self.assignEquipmentInfo()
                
                completion(.success)
                
            } else {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Equipment Info data"))
            }
        }
    }
    
    private func assignEquipmentInfo() {
        
        // TODO get from coredata
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
            ]) { [weak self] err in
                guard let self = self else { return }
                if let err = err {
                    completion(.failure(err.localizedDescription + "voxERR fail to update Equipment Info"))
                } else {
                    print("Successfully update lab with id: \(equipmentId)")
                    // TODO save to Core Data

                    
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
