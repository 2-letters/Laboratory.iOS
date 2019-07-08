//
//  InputHighlightable.swift
//  Laboratory
//
//  Created by Huy Vo on 7/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

protocol InputHighlightable {
    func highlight()
    
    func unhighlight()
    
    func warnInput()
}

extension InputHighlightable where Self: UIView {
    func highlight() {
        layer.shadowOffset = CGSize(width: 0.0, height: 3)
        layer.shadowColor = MyColor.lightBlue.cgColor
    }
    
    func unhighlight() {
        layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        layer.shadowColor = UIColor.black.cgColor
    }
    
    func warnInput() {
        layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        layer.shadowColor = MyColor.redWarning.cgColor
    }
}

extension UITextView: InputHighlightable {}
extension UITextField: InputHighlightable {}
