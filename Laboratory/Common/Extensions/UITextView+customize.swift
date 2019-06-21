//
//  UITextView+customize.swift
//  Laboratory
//
//  Created by Huy Vo on 5/25/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

extension UITextView {
    func customize(withText text: String? = nil, isEditable: Bool = false) {
        if let text = text {
            self.text = text
        }
        
        if (isEditable) {
            self.isEditable = isEditable
            self.layer.backgroundColor = UIColor.white.cgColor

            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.gray.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 0.0
        }
        
        self.isScrollEnabled = false
        self.font = UIFont(name: secondaryFont, size: 20)
    }
    
    func highlight() {
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3)
        self.layer.shadowColor = Color.lightBlue.cgColor
    }
    
    func unhighlight() {
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        self.layer.shadowColor = UIColor.gray.cgColor
    }
}
