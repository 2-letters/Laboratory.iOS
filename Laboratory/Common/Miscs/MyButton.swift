//
//  MyButton.swift
//  Laboratory
//
//  Created by Huy Vo on 7/5/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

enum MyButtonCase {
    case primary
    case danger
}

class MyButton: UIButton {
//    private let secondaryFont = "GillSans"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        titleLabel?.font = UIFont(name: "GillSans", size: 17)
    }
    
    func customize(forCase buttonCase: MyButtonCase) {
        switch buttonCase {
        case .primary:
            backgroundColor = MyColor.lightGreen
            setTitleColor(UIColor.white, for: .normal)
        case .danger:
            backgroundColor = MyColor.superLightGreen
            setTitleColor(MyColor.redWarning, for: .normal)
        }
    }
}
