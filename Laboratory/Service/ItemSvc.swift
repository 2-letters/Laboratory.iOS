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
    case success([ItemVM])
    case failure(String)
}

struct ItemSvc {
    static func fetchItemData(completion: @escaping (ItemResult) -> Void) {
        var itemVMs = [ItemVM]()
        Firestore.firestore().collection("institutions").document("MXnWedK2McfuhBpVr3WQ").collection("items").order(by: "itemName", descending: false).getDocuments { (snapshot, error) in
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Items data"))
            } else {
                for document in (snapshot!.documents) {
                    if let itemName = document.data()["itemName"] as? String
//                        let description = document.data()["description"] as? String,
//                        let quantity = document.data()["quantity"] as? Int,
//                        let location = document.data()["location"] as? String,
//                        let photoUrl = document.data()["photoUrl"] as? String
                    {
                        itemVMs.append(ItemVM(item: Item(name: itemName)))
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
}
