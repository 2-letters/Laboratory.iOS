//
//  MyCache.swift
//  Laboratory
//
//  Created by Huy Vo on 7/14/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

class MyCache: NSCache<AnyObject, AnyObject> {
    static let shared = NSCache<AnyObject, AnyObject>()
    private override init() {
        super.init()
    }
}
