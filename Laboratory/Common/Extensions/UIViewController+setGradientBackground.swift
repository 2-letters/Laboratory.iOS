//
//  UIViewController+setGradientBackground.swift
//  Laboratory
//
//  Created by Huy Vo on 5/14/20.
//  Copyright © 2020 2Letters. All rights reserved.
//

import UIKit

extension UIViewController {
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = self.view.bounds
     
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.colors = [MyColor.loginPurple1.cgColor, MyColor.loginPurple2.cgColor, MyColor.loginPurple3.cgColor,
        MyColor.loginPurple4.cgColor, MyColor.loginPurple5.cgColor]
     
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
