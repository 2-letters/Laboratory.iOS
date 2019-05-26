//
//  LabAssignmentViewModel.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

// For Lab ViewController
class LabVM {
    var allLabs: [Lab]?
    var displayingLabs: [Lab]?
    
    func getName(at index: Int) -> String {
        return displayingLabs![index].name
    }
    
    func fetchLabData(completion: @escaping FetchHandler) {
         Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").order(by: "labName", descending: false).getDocuments { [unowned self ](snapshot, error) in
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Labs data"))
            } else {
                var labs = [Lab]()
                for document in (snapshot!.documents) {
                    if let labName = document.data()["labName"] as? String {
                        labs.append(Lab(name: labName))
                    }
                }
                self.allLabs = labs
                self.displayingLabs = labs
                completion(.success)
            }
        }
    }
    
    func search(by text: String) {
        displayingLabs = allLabs?.filter({$0.name.lowercased()
            .prefix(text.count) == text.lowercased()})
    }
}
