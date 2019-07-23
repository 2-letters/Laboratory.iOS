//
//  UIView+initFromNib.swift
//  Laboratory
//
//  Created by Huy Vo on 6/9/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

extension UIView {
    class func initFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
