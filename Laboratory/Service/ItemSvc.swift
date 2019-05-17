//
//  ItemSvc.swift
//  Laboratory
//
//  Created by Huy Vo on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum ItemResult {
    case success([LabItemEditVM])
    case failure(String)
}

enum ItemInfoResult {
    case success(ItemVM)
    case failure(String)
}

struct ItemSvc {
    static func fetchItemData(completion: @escaping (ItemResult) -> Void) {
        var itemVMs = [LabItemEditVM]()
        Firestore.firestore().collection("institutions").document("MXnWedK2McfuhBpVr3WQ").collection("items").order(by: "name", descending: false).getDocuments { (snapshot, error) in
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Items data"))
            } else {
                for document in (snapshot!.documents) {
                    if let itemName = document.data()["name"] as? String
//                        let description = document.data()["description"] as? String,
//                        let quantity = document.data()["quantity"] as? Int,
//                        let location = document.data()["location"] as? String,
//                        let photoUrl = document.data()["photoUrl"] as? String
                    {
                        itemVMs.append(LabItemEditVM(LabItem(itemName: itemName)))
                    }
//                    guard let itemName = document.data()["itemName"] else {
//                        return
//                    }
//                    guard let ite
                }
                completion(.success(itemVMs))
            }
        }
    }
    
    static func fetchItemInfo(byName name: String, completion: @escaping (ItemInfoResult) -> Void) {
        // TODO: get department and instituion from Cache?
    Firestore.firestore().collection("institutions").document("MXnWedK2McfuhBpVr3WQ").collection("items").whereField("name", isEqualTo: name).getDocuments { (snapshot, error) in
        if error != nil {
            completion(.failure(error?.localizedDescription ?? "ERR fetching Item Info data"))
        } else {
            let document = snapshot!.documents.first!
            if let itemName = document.data()["name"] as? String,
                let quantity = document.data()["quantity"] as? Int,
                let description = document.data()["description"] as? String,
                let location = document.data()["location"] as? String,
                let pictureUrl = document.data()["pictureUrl"] as? String
            {
                completion(.success(ItemVM(item: Item(name: itemName, quantity: quantity, description: description, location: location, pictureUrl: pictureUrl))))
            } else {
                completion(.failure(error?.localizedDescription ?? "ERR converting Item Info into Item class"))
            }
        }
        }
    }
}
