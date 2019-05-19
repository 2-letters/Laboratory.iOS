//
//  LabInfoVC.swift
//  Laboratory
//
//  Created by Developers on 5/17/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabInfoVC: UIViewController {

    @IBOutlet var labInfoView: LabInfoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labInfoView.addEquipmentsBtn.setTitle("Edit equipments...", for: .normal)
        labInfoView.addEquipmentsBtn.addTarget(self, action: #selector(editEquipments), for: .touchUpInside)
    }
    
    @objc func editEquipments() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let labEquipmentSelectionVC = storyboard.instantiateViewController(withIdentifier: "labEquipmentSelectionVC")
        let navController = UINavigationController(rootViewController: labEquipmentSelectionVC)
        present(navController, animated: true, completion: nil)
    }

}
