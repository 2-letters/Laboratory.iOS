//
//  LabEquipmentEditViewModel.swift
//  Laboratory
//
//  Created by Huy Vo on 5/24/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

//import Foundation
//
//class LabEquipmentEditViewModel {
//    
//    var equipmentName: String
//    var equipmentInfoVM: EquipmentInfoVM?
//    
//    init(equipmentName: String) {
//        self.equipmentName = equipmentName
//    }
//    
//    func fetchEquipmentInfo(completion: @escaping (FetchResult) -> ()) {
//        EquipmentSvc.fetchEquipmentInfo(byName: equipmentName) { [unowned self] (itemInfoResult) in
//            switch itemInfoResult {
//            case let .failure(errorStr):
//                print(errorStr)
//                completion(.failure)
//            case let .success(viewModel):
//                self.equipmentInfoVM = viewModel
//                completion(.success)
//            }
//        }
//    }
//}
