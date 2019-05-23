//
//  LabInfoVM.swift
//  Laboratory
//
//  Created by Developers on 5/21/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation
import FirebaseFirestore

// Handle networking
enum LabEquipmentResult {
    case success(LabInfo)
    case failure(String)
}
// Fetching data completion handler
typealias FetchLabEquipmentHandler = (LabEquipmentResult) -> Void

class LabInfoVM {
    var labInfo: LabInfo?
    var labName: String { return labInfo!.name }
    var description: String { return labInfo!.description }
    var equipmentVMs: [LabEquipmentVM]?
    
    var accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator
    
    init(labInfo: LabInfo) {
        self.labInfo = labInfo
//        labName = labInfo.name
//        equipmentVMs = [LabEquipmentVM]()
        equipmentVMs = labInfo.equipments.map({ LabEquipmentVM(equipment: $0) })
    }
    
    init(name: String) {
        labInfo = LabInfo(name: name)
    }
    
    
    // TODO: fix this mess. Check with firebase and see if Real Lab can be formatted to Lab Info this way
    func fetchLabEquipment(byName labName: String?, completion: @escaping FetchLabEquipmentHandler) {
        guard let name = labName else {
            completion(.failure("ERR could not load Lab Name"))
            return
        }
    Firestore.firestore().collection("users").document("uY4N6WXX7Ij9syuL5Eb6").collection("labs").document(name)
        .getDocument { (document, error) in
            if let labInfo = document.flatMap({
                $0.data().flatMap({ (data) in
                    completion(.success(LabInfo(dictionary: data)))
                })
            }) {
                print("lab info: \(labInfo)")
            } else {
                completion(.failure("ERR Lab Info does not exist"))
            }
                
//                if error != nil {
//                    completion(.failure(error?.localizedDescription ?? "ERR fetching Lab Equipments data"))
//                } else {
//                    for document in (snapshot!.data()["equipments"])
//                    {
//                        guard let equipmentName = document.data()["itemName"] as? String,
//                            let quantity =
//                            document.data()["quantity"] as? Int
//                            else
//                        {
//                            completion(.failure("ERR reading datas from Lab Equipment"))
//                            return
//                        }
//                        labEquipments.append(LabEquipmentVM(equipment: LabEquipment(
//                            name: equipmentName, quantity: quantity)))
//                    }
//                    completion(.success(labEquipments))
//                }
        }
    }
    
//    func loadLabEquipments() {
////        guard let labName = labInfo.name else {
////            return
////        }
//        LabSvc.fetchLabEquipment(byName: labInfo.name) { [unowned self] (labEquipmentResult) in
//            switch labEquipmentResult {
//            case let .failure(errorStr):
//                print(errorStr)
//            case let .success(equipments):
//                self.labInfo.equipments = equipments
//                // successfully fetch lab equipments data, reload the table view
//                
//                self.labEquipmentTableView?.reloadData()
//            }
//        }
//    }
}
