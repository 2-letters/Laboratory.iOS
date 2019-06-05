//
//  LabListVM.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

// For Lab List ViewController
class LabListVM {
    var allLabVMs: [LabVM]?
    var displayingLabVMs: [LabVM]?
    
    func getLabId(at index: Int) -> String {
        return displayingLabVMs![index].labId
    }
    
    func fetchLabData(completion: @escaping FetchFirestoreHandler) {
         Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").order(by: "labName", descending: false).getDocuments { [unowned self ](snapshot, error) in
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Labs data"))
            } else {
                var labVMs = [LabVM]()
                for document in (snapshot!.documents) {
                    if let labName = document.data()["labName"] as? String,
                    let description = document.data()["description"] as? String {
                        labVMs.append(LabVM(lab: Lab(id: document.documentID, name: labName, description: description)))
                    }
                }
                self.allLabVMs = labVMs
                self.displayingLabVMs = labVMs
                completion(.success)
            }
        }
    }
    
    func search(by text: String) {
        if text == "" {
            displayingLabVMs = allLabVMs
        } else {
            displayingLabVMs = allLabVMs?.filter({$0.labName.lowercased().contains(text.lowercased())})
        }
    }
}
