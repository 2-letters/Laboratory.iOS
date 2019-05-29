//
//  LabCreateVC.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabCreateVC: UIViewController {

    @IBOutlet private var labCreateView: LabInfoView!
    
    private var viewModel = LabCreateVM()
    
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
            let ac = UIAlertController(title: AlertString.oopsTitle, message: AlertString.failToSaveLabInfoMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        } else {
            // create a new lab on FireStore
            viewModel.createLab(withName: newLabName, description: newLabDescription) { (createResult) in
                switch createResult {
                case .success:
                    print("Successfully add a new lab: \(newLabName)")
                    // TODO make alert congrats on success
                case let .failure(errorStr):
                    print(errorStr)
                    // TODO make alert oops on fail
                }
            }
            dismiss(animated: true, completion: nil)
        }
    }
}

//extension LabCreateVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}
