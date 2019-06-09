//
//  SpinnerPresenter.swift
//  Laboratory
//
//  Created by Huy Vo on 5/27/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

protocol SpinnerPresentable {
    var spinnerVC: SpinnerViewController { get }
    func showSpinner()
    func hideSpinner()
}

extension SpinnerPresentable where Self: UIViewController {
    func showSpinner() {
        // add the spinner view controller
        addChild(spinnerVC)
        spinnerVC.view.frame = view.frame
        view.addSubview(spinnerVC.view)
        spinnerVC.didMove(toParent: self)
        
    }
    
    func hideSpinner() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // then remove the spinner view controller
            self.spinnerVC.willMove(toParent: nil)
            self.spinnerVC.view.removeFromSuperview()
            self.spinnerVC.removeFromParent()
        }
    }
}

class SpinnerViewController: UIViewController {
    private var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
