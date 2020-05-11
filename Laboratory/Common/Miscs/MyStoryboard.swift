//
//  MyStoryboard.swift
//  Laboratory
//
//  Created by Developers on 6/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

enum MyStoryboard: String {
    case main = "Main"
    case login = "Login"
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
