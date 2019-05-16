//
//  EquipmentInfoVC.swift
//  Laboratory
//
//  Created by Developers on 5/16/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class EquipmentInfoVC: UIViewController {

    var equipmentName: String = "" {
        didSet {
            loadEquipmentInfo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    

    func loadEquipmentInfo() {
//        ItemSvc.fetchtemInfo(byName:)
    }

}
