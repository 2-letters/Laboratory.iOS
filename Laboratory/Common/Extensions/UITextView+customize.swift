//
//  UITextView+customize.swift
//  Laboratory
//
//  Created by Huy Vo on 5/25/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class MyTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        
        isScrollEnabled = false
        font = UIFont(name: "GillSans", size: 19)
        // remove left padding
        textContainer.lineFragmentPadding = 0
        
        customize(forEditing: true)
    }
    
    func customize(forEditing isEditing: Bool) {
        if isEditable != isEditing {
            isEditable = isEditing
        }
        
        if (isEditing) {
            layer.shadowColor = UIColor.black.cgColor
        } else {
            layer.shadowColor = MyColor.lightGray.cgColor
        }
    }
}


class MyTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        borderStyle = .none
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        
        font = UIFont(name: "GillSans", size: 19)
        
        customize(forEditing: true)
    }
    
    func customize(forEditing isEnabled: Bool) {
        self.isEnabled = isEnabled
        if (isEnabled) {
            layer.shadowColor = UIColor.black.cgColor
        } else {
            layer.shadowColor = MyColor.lightGray.cgColor
        }
    }
}
