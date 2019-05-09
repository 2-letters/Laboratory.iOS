//
//  LabAssignmentSvc.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

class LabSvc {
    
    var db: Firestore
    init() {
        db = Firestore.firestore()
    }
    
//    func fetchData() -> [LabVM] {
//
//
//        let labVMs = [
//            LabVM(Lab(name: "lab1", description: "abc")),
//            LabVM(Lab(name: "lab2", description: "abc2")),
//        ]
//        return labVMs
//    }
    
    func fetchData() -> [LabVM] {
        var labVMs = [LabVM]()
        db.collection("Lab").order(by: "labName", descending: false).getDocuments { (snapshot, error) in
            if error != nil {
                print(error ?? "Error fetching data")
            } else {
                for document in (snapshot?.documents)! {
                    if let labName = document.data()["labName"] as? String {
                        if let description = document.data()["description"] as? String {
                            labVMs.append(LabVM(Lab(name: labName, description: description)))
                        }
                    }
                }
            }
        }
        return labVMs
    }
    
    func filter(with searchText: String) -> [LabVM] {
        let labAssignmentVMs = [
            LabVM(Lab(name: "lab1", description: "abc")),
            LabVM(Lab(name: "lab2", description: "abc2")),
            ]
        
        let searchedLabAssignmentVms = labAssignmentVMs
            .filter({$0.labName.lowercased()
                .prefix(searchText.count) == searchText.lowercased()})
        
        return searchedLabAssignmentVms
    }
}
