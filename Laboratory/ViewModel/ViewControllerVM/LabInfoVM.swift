//
//  LabInfoVM.swift
//  Laboratory
//
//  Created by Developers on 5/21/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore


class LabInfoVM {
    var labInfo: LabInfo?
    
//    init(labInfo: LabInfo) {
//        self.labInfo = labInfo
//    }
    
    var labName: String { return labInfo!.name }
    var description: String { return labInfo!.description }
    var equipmentVMs: [LabEquipmentVM]? {
        return labInfo?.equipments.map({ LabEquipmentVM(equipment: $0) })
    }
    
//    init(name: String) {
//        labInfo = LabInfo(name: name)
//    }
    
    func fetchLabInfo(byName labName: String?, completion: @escaping FetchHandler) {
        guard let name = labName else {
            completion(.failure("ERR could not load Lab Name"))
            return
        }
    Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").document(name)
        .getDocument { [unowned self] (document, error) in
            if error != nil {
                completion(.failure(error?.localizedDescription ?? "ERR fetching Lab Info"))
            } else {
                if let labName = document!.data()!["labName"] as? String,
                let description = document!.data()!["description"] as? String {
                    FirestoreSvc.fetchLabEquipments(byLabName: labName, completion: { (fetchLabEquipmentResult) in
                        switch fetchLabEquipmentResult {
                        case let .success(labEquipments):
                            self.labInfo = LabInfo(name: labName, description: description, equipments: labEquipments)
                            completion(.success)
                        case let .failure(errorStr):
                            completion(.failure(errorStr))
                        }
                    })
                } else {
                    completion(.failure("ERR converting Lab Info data"))
                }
            }
//            if let labInfo = document.flatMap({
//                $0.data().flatMap({ (data) in
//                    return LabInfo(dictionary: data)
//                })
//            }) {
//                self.labInfo = labInfo
//                completion(.success)
//            } else {
//                completion(.failure("ERR Lab Info does not exist"))
//            }
        }
    }
}
