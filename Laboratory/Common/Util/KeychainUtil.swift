//
//  KeychainUtil.swift
//  Laboratory
//
//  Created by Huy Vo on 5/10/20.
//  Copyright © 2020 2Letters. All rights reserved.
//

import Foundation
import KeychainAccess

class KeychainUtil {
    var keyChain: Keychain
    
    init() {
        keyChain = Keychain(server: Bundle.main.bundleIdentifier!, protocolType: .https)
    }
    
}
