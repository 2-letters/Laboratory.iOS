//
//  UITextView+customize.swift
//  Laboratory
//
//  Created by Huy Vo on 5/25/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

extension UITextView {
    func customize(withText text: String? = nil, isEditable: Bool) {
        if let text = text {
            self.text = text
        }
        
        if (isEditable) {
            self.layer.shadowColor = UIColor.gray.cgColor
        } else {
            self.layer.shadowColor = MyColor.separatingLine.cgColor
        }
        
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
        self.isEditable = isEditable
        self.isScrollEnabled = false
        self.font = UIFont(name: secondaryFont, size: 19)
        // remove left padding
        self.textContainer.lineFragmentPadding = 0
    }
    
    func highlight() {
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3)
        self.layer.shadowColor = MyColor.lightBlue.cgColor
    }
    
    func unhighlight() {
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        self.layer.shadowColor = UIColor.gray.cgColor
    }
}

extension UITextField {
    func customize(withText text: String? = nil, isEditable: Bool) {
        if let text = text {
            self.text = text
        }
        
        if (isEditable) {
            self.layer.shadowColor = UIColor.black.cgColor
        } else {
            self.layer.shadowColor = MyColor.separatingLine.cgColor
        }
        
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
        self.isEnabled = isEditable
        self.font = UIFont(name: secondaryFont, size: 19)
    }
    
    func highlight() {
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3)
        self.layer.shadowColor = MyColor.lightBlue.cgColor
    }
    
    func unhighlight() {
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        self.layer.shadowColor = UIColor.gray.cgColor
    }
}
