//
//  LoginViewController.swift
//  Laboratory
//
//  Created by Huy Vo on 5/10/20.
//  Copyright © 2020 2Letters. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var loginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
