//
//  ForgotPasswordViewController.swift
//  Laboratory
//
//  Created by Huy Vo on 5/10/20.
//  Copyright © 2020 2Letters. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var forgotPasswordLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var emailTextField: MyTextField!
    @IBOutlet var sendEmailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTapRecognizer()
        customizeUI()
    }

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Helper
    func customizeUI() {
        setGradientBackground()
        
        doneButton.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "GillSans", size: 19.0)!
        ], for: .normal)
        forgotPasswordLabel.setBigBold()
        emailLabel.setNormal()
        sendEmailButton.setWhite()
    }

}
