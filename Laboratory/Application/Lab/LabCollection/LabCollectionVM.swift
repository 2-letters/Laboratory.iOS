//
//  LabCollectionVM.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

// For Lab List ViewController
class LabCollectionVM {
//    let firestoreUtil = FirestoreUtil.shared
    var allLabVMs: [LabCellVM]?
    var displayingLabVMs: [LabCellVM]?
    
    func getLabId(at index: Int) -> String {
        return displayingLabVMs![index].labId
    }
    
    func fetchLabData(completion: @escaping FetchFirestoreHandler) {
         FirestoreUtil.fetchLabsOrdered().getDocuments { [weak self] (snapshot, error) in
            guard let self = self else { return }
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Labs data"))
            } else {
                self.assignLabs(with: snapshot)
                completion(.success)
            }
        }
    }
    
    private func assignLabs(with snapshot: QuerySnapshot?) {
        var labVMs = [LabCellVM]()
        for document in (snapshot!.documents) {
            if let labName = document.data()[LabKey.name] as? String,
                let description = document.data()[LabKey.description] as? String {
                labVMs.append(LabCellVM(lab: Lab(id: document.documentID, name: labName, description: description)))
            }
        }
        self.allLabVMs = labVMs
        self.displayingLabVMs = labVMs
    }
    
    func search(by text: String) {
        if text == "" {
            displayingLabVMs = allLabVMs
        } else {
            displayingLabVMs = allLabVMs?.filter({$0.labName.lowercased().contains(text.lowercased())})
        }
    }
}
