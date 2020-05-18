//
//  SignUpViewController.swift
//  Laboratory
//
//  Created by Huy Vo on 5/10/20.
//  Copyright © 2020 2Letters. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var signUpLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var confirmPasswordLabel: UILabel!
    @IBOutlet var emailTextField: MyTextField!
    @IBOutlet var passwordTextField: MyTextField!
    @IBOutlet var confirmPasswordTextField: MyTextField!
    @IBOutlet var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTapRecognizer()
        customizeUI()
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
        
        signUpLabel.setBigBold()
        emailLabel.setNormal()
        passwordLabel.setNormal()
        confirmPasswordLabel.setNormal()
        signUpButton.setGreen()
        
    }
}
