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
    @IBOutlet var saveBtn: UIBarButtonItem!
    
    var labVM: LabVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: Layout
    func setupUI() {
        // setup the Lab info views
        labInfoView.nameTextField.text = labVM?.labName
        labInfoView.descriptionTextField.text = labVM?.description
        
        // change button title to "Edit Equipments..."
        labInfoView.addEquipmentsBtn.setTitle("Edit Equipments...", for: .normal)
        labInfoView.addEquipmentsBtn.addTarget(self, action: #selector(editEquipments), for: .touchUpInside)
        
        // disable Save button until some change is made
        saveBtn.isEnabled = false
    }
}


// MARK: - User Interaction
extension LabInfoVC {
    @objc func editEquipments() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let labEquipmentSelectionVC = storyboard.instantiateViewController(withIdentifier: "labEquipmentSelectionVC")
        let navController = UINavigationController(rootViewController: labEquipmentSelectionVC)
        present(navController, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        // TODO save the changes
    }
}
