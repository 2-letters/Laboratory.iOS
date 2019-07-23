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
        // notify the child spinnerVC that it was moved to a parent
        spinnerVC.didMove(toParent: self)
        
    }
    
    func hideSpinner() {
        if spinnerVC.parent != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self = self else { return }
                // notify the child that it’s about to be removed
                self.spinnerVC.willMove(toParent: nil)
                // Then, remove the child from its parent
                self.spinnerVC.view.removeFromSuperview()
                // Finally, remove the child’s view from the parent’s
                self.spinnerVC.removeFromParent()
            }
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
