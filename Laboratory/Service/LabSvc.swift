//
//  LabAssignmentSvc.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum LabResult {
    case success([LabVM])
    case failure(String)
}

enum LabItemResult {
    case success([LabItemVM])
    case failure(String)
}


class LabSvc {
    static func fetchLabData(completion: @escaping (LabResult) -> Void) {
        var labVMs = [LabVM]()
        Firestore.firestore().collection("Lab").order(by: "labName", descending: false).getDocuments { (snapshot, error) in
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Labs data"))
            } else {
                for document in (snapshot?.documents)! {
                    if let labName = document.data()["labName"] as? String {
                        if let description = document.data()["description"] as? String {
                            labVMs.append(LabVM(Lab(name: labName, description: description)))
                            completion(.success(labVMs))
                        }
                    }
                }
            }
        }
    }
    
    static func filterLab(with searchText: String) -> [LabVM] {
        let labAssignmentVMs = [
            LabVM(Lab(name: "lab1", description: "abc")),
            LabVM(Lab(name: "lab2", description: "abc2")),
            ]
        
        let searchedLabAssignmentVms = labAssignmentVMs
            .filter({$0.labName.lowercased()
                .prefix(searchText.count) == searchText.lowercased()})
        
        return searchedLabAssignmentVms
    }
    
    static func fetchLabItem(completion: @escaping (LabItemResult) -> Void) {
        var labItemVMs = [LabItemVM]()
        Firestore.firestore().collection("LabItem").order(by: "itemName", descending: false)
            .getDocuments { (snapshot, error) in
            
                if error != nil {
                    completion(.failure(error?.localizedDescription ?? "ERR fetching Lab Items data"))
                } else {
                    for document in (snapshot?.documents)! {
                        guard let itemName = document.data()["itemName"] as? String else {
                            completion(.failure("ERR fetching Lab Item name"))
                            return
                        }
                        guard let quantity = document.data()["quantity"] as? Int else {
                            completion(.failure("ERR fetching Lab Item name"))
                            return
                        }
                        labItemVMs.append(LabItemVM(LabItem(itemName: itemName, quantity: quantity)))
                        completion(.success(labItemVMs))
                    }
                    completion(.success(labItemVMs))
                }
        }
    }
}
