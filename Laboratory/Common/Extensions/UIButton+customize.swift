//
//  UIButton+customize.swift
//  Laboratory
//
//  Created by Huy Vo on 5/14/20.
//  Copyright © 2020 2Letters. All rights reserved.
//

import UIKit

extension UIButton {
    func setWhite() {
        self.titleLabel?.font = UIFont(name: "GillSans-SemiBold", size: 17.0)
        self.setTitleColor(MyColor.lightLavender, for: .normal)
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.backgroundColor = UIColor.white
    }
    
    func setGreen() {
        self.titleLabel?.font = UIFont(name: "GillSans-SemiBold", size: 17.0)
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.backgroundColor = MyColor.lightGreen
    }
}
