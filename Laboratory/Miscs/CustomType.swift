//
//  CustomType.swift
//  Laboratory
//
//  Created by Developers on 5/23/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

let globalFont = "GillSans-SemiBold"

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
    case success
    case failure(String)
}
