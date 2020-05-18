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
        setupBorder()
        
        isScrollEnabled = false
        font = UIFont(name: "GillSans", size: 19)
        // remove left padding
        textContainer.lineFragmentPadding = 0
        
        customize(forEditing: true)
    }
    
    private func setupBorder() {
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
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
    let bottomLine = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        setupBorder()
        
        font = UIFont(name: "GillSans", size: 19)
//        customizeForEditing()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // resize bottom line on Text field bounds change
        bottomLine.frame = CGRect(x: 0.0, y: frame.height + 5, width: frame.width, height: 1.0)
    }
    
    private func setupBorder() {
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
        
//        borderStyle = .none
//        layer.backgroundColor = UIColor.clear.cgColor
//        layer.masksToBounds = false
//        layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
//        layer.shadowOpacity = 1.0
//        layer.shadowRadius = 0.0
    }
    
    func customizeForEditing() {
        self.isEnabled = true
        layer.shadowColor = UIColor.black.cgColor
    }
    
    func customizeForViewOnly() {
        self.isEnabled = false
        layer.shadowColor = MyColor.lightGray.cgColor
    }
}
