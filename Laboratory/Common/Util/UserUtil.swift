//
//  UserUtil.swift
//  Laboratory
//
//  Created by Huy Vo on 6/23/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

struct UserUtil {
    static var userId: String {
        get {
            let id =  UserDefaults.standard.string(forKey: "userId")
            guard let userId = id else {
                preconditionFailure("voxErr cannot load userId")
            }
            return userId
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
    }
    
    static var institutionId: String {
        get {
            let id =  UserDefaults.standard.string(forKey: "institutionId")
            guard let institutionId = id else {
                preconditionFailure("voxErr cannot load userId")
            }
            return institutionId
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "institutionId")
        }
    }
}
