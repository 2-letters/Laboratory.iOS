//
//  LabEquipmentEditVC.swift
//  Laboratory
//
//  Created by Developers on 5/23/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabEquipmentEditVC: UIViewController {

    @IBOutlet var usingEquipmentTextField: UITextField!
    @IBOutlet var equipmentInfoView: EquipmentInfoView!
    
    var usingEquipmentCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func decreaseEquipment(_ sender: UIButton) {
        
    }
    
    @IBAction func increaseEquipment(_ sender: UIButton) {
    }
    
    @IBAction func removeEquipment(_ sender: UIButton) {
    }
}
