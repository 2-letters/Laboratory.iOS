//
//  CustomType.swift
//  Laboratory
//
//  Created by Developers on 5/23/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

typealias CreateFirestoreHandler = (CreateResult) -> Void

enum CreateResult {
    case success(String)
    case failure(String)
}


typealias FetchFirestoreHandler = (FetchResult) -> Void

enum FetchResult {
    case success
    case failure(String)
}


typealias UpdateFirestoreHandler = (UpdateFirestoreResult) -> Void

enum UpdateFirestoreResult {
    case success(String?)
    case failure(String)
}

typealias DeleteFirestoreHandler = (DeleteFirestoreResult) -> Void

enum DeleteFirestoreResult {
    case success
    case failure(String)
}

typealias FetchAllEquipmentHandler = (FetchAllEquipmentResult) -> Void

enum FetchAllEquipmentResult {
    case success([SimpleEquipmentVM])
    case failure(String)
}



typealias FetchLabEquipmentHandler = (FetchLabEquipmentResult) -> Void

enum FetchLabEquipmentResult {
    case success([LabEquipment])
    case failure(String)
}

