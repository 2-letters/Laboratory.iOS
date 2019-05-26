//
//  EquipmentInfoVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class EquipmentInfoVM {
    var equipment: FullEquipment?
    var equipmentName: String {
        return "Name:  \(equipment!.name)"
    }
    var availableString: String {
        return "Available:  \(equipment!.available) (items)"
    }
    var available: Int {
        return equipment?.available ?? 0
    }
    var description: String {
        return equipment!.description
    }
    var location: String {
        return equipment!.location
    }
    var pictureUrl: String {
        return equipment!.pictureUrl
    }
    
    func fetchEquipmentInfo(byName name: String, completion: @escaping (FetchResult) -> ()) {
        EquipmentSvc.fetchEquipmentInfo(byName: name) { [unowned self] (itemInfoResult) in
            switch itemInfoResult {
            case let .failure(errorStr):
                print(errorStr)
                completion(.failure)
            case let .success(fullEquipment):
                self.equipment = fullEquipment
                completion(.success)
            }
        }
    }
}
