//
//  LabCreateVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/26/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct LabCreateVM {
    func createLab(withName name: String, description: String, completion: @escaping FetchFirestoreHandler) {
        Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6")
            .collection("labs").addDocument(data: [
                "labName" : name,
                "description": description
            ]) { err in
            if let err = err {
                completion(.failure("ERR creating a new Lab \(err)"))
            } else {
                completion(.success)
            }
        }
    }
}
