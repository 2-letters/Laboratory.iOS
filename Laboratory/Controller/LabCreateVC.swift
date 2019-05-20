//
//  LabCreateVC.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabCreateVC: UIViewController {

    @IBOutlet var labCreateView: LabInfoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labCreateView.addEquipmentsBtn.addTarget(self, action: #selector(addEquipments), for: .touchUpInside)
    }
}

// MARK: - User Interaction
extension LabCreateVC {
    @objc func addEquipments() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let labEquipmentSelectionVC = storyBoard.instantiateViewController(withIdentifier: "labEquipmentSelectionVC") as! LabEquipmentSelectionVC
        let navController = UINavigationController(rootViewController: labEquipmentSelectionVC)
        present(navController, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneAddingLab(_ sender: UIBarButtonItem) {
        let newLabName = labCreateView.nameTextField.text ?? ""
        let newLabDescription = labCreateView.descriptionTextField.text ?? ""
        
        if (newLabName.isEmpty || newLabDescription.isEmpty) {
            let ac = UIAlertController(title: "Oops!", message: "Please make sure your lab has a name.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        } else {
            LabSvc.createLab(withName: newLabName, description: newLabDescription)
            dismiss(animated: true, completion: nil)
        }
    }
}

extension LabCreateVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
