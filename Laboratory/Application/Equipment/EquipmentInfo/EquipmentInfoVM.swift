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
    
    func fetchEquipmentInfo(byName name: String, completion: @escaping FetchFirestoreHandler) {
        // TODO: get department and instituion from Cache?
        Firestore.firestore().collection("institutions").document("MXnWedK2McfuhBpVr3WQ").collection("items").whereField("name", isEqualTo: name).getDocuments { [weak self] (snapshot, error) in
            guard let self = self else { return }
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Equipment Info data"))
            } else {
                let document = snapshot!.documents.first!
                if let equipmentName = document.data()["name"] as? String,
                    let quantity = document.data()["available"] as? Int,
                    let description = document.data()["description"] as? String,
                    let location = document.data()["location"] as? String,
                    let pictureUrl = document.data()["pictureUrl"] as? String
                {
                    self.equipment = FullEquipment(name: equipmentName, available: quantity, description: description, location: location, pictureUrl: pictureUrl)
                    completion(.success)
                } else {
                    completion(.failure(error?.localizedDescription ?? "ERR converting Equipment Info into Equipment class"))
                }
            }
        }
    }
}
