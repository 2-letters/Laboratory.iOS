//
//  UIViewController+addTapRecognizer.swift
//  Laboratory
//
//  Created by Developers on 6/13/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

extension UIViewController {
    func addTapRecognizer(toView theView: UIView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        theView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
