//
//  LoginViewController.swift
//  Laboratory
//
//  Created by Huy Vo on 5/10/20.
//  Copyright © 2020 2Letters. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var laboratoryTitle: UILabel!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var rememberMeLabel: UILabel!
    @IBOutlet var emailTextField: MyTextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var rememberMeSwitch: UISwitch!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var forgotPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTapRecognizer()
        customizeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // hide navigation bar for login view
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // show navigation bar for other views
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // TODO: save the actual token
        let keychain = KeychainUtil().keyChain
        try! keychain.set("token", key: "token")
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.rootViewController = MyViewController.homeTabBar.instance
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
        
        laboratoryTitle.setTitle()
        loginLabel.setBigBold()
        emailLabel.setNormal()
        passwordLabel.setNormal()
        rememberMeLabel.setNormal()
        loginButton.setWhite()
        signUpButton.setGreen()
        rememberMeSwitch.onTintColor = MyColor.lightGreen
        forgotPasswordButton.setWhite()
    }
    
    
}
