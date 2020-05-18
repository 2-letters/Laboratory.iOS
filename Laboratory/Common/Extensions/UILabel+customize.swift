//
//  UILabel+customize.swift
//  Laboratory
//
//  Created by Huy Vo on 5/11/20.
//  Copyright © 2020 2Letters. All rights reserved.
//

import UIKit

extension UILabel {
    func setTitle() {
        self.font = UIFont(name:"GillSans", size: 22.0)
        self.textColor = UIColor.white
    }
    
    func setNormal() {
        self.font = UIFont(name: "GillSans", size: 19.0)
        self.textColor = UIColor.white
    }
    
    func setBigBold() {
        self.font = UIFont(name:"GillSans-SemiBold", size: 40.0)
        self.textColor = UIColor.white
    }
}
