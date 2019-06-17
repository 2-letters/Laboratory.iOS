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
    var equipment: FullEquipment?
    var equipmentName: String {
        return "Name:  \(equipment!.name)"
    }
    var availableString: String {
        return "Available:  \(equipment!.available) (items)"
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
    var pictureUrl: String {
        return equipment!.pictureUrl
    }
    
    func fetchEquipmentInfo(byId equipmentId: String?, completion: @escaping FetchFirestoreHandler) {
        // TODO: get department and instituion from Cache?
        guard let equipmentId = equipmentId else {
            completion(.failure("ERR could not load Lab Id"))
            return
        }
        Firestore.firestore().collection("institutions").document("MXnWedK2McfuhBpVr3WQ").collection("items").document(equipmentId).getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            if let document = document, document.exists {
                let docData = document.data()!
                let equipmentName = docData["name"] as! String
                let quantity = docData["available"] as! Int
                let description = docData["description"] as! String
                let location = docData["location"] as! String
                let pictureUrl = docData["pictureUrl"] as! String
                self.equipment = FullEquipment(name: equipmentName, available: quantity, description: description, location: location, pictureUrl: pictureUrl)
                    completion(.success)
            } else {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Equipment Info data"))
            }
        }
    }
}
