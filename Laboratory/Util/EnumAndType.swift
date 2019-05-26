//
//  Enum.swift
//  Laboratory
//
//  Created by Developers on 5/23/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

typealias FetchHandler = (FetchResult) -> Void

enum FetchResult {
    case success
    case failure(String)
}
