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
    
    var labEquipmentTableView: UITableView?
    var labVM: LabVM?
    var labEquipmentVMs = [LabEquipmentVM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        labEquipmentTableView?.delegate = self
        labEquipmentTableView?.dataSource = self
        
        loadLabEquipments()
    }
    
    func loadLabEquipments() {
        guard let labName = labVM?.labName else {
            return
        }
        LabSvc.fetchLabEquipment(byName: labName) { [unowned self] (labEquipmentResult) in
            switch labEquipmentResult {
            case let .failure(errorStr):
                print(errorStr)
            case let .success(viewModels):
                self.labEquipmentVMs = viewModels
                // successfully fetch lab equipments data, reload the table view
                self.labEquipmentTableView?.reloadData()
            }
        }
    }
    
    // MARK: Layout
    func setupUI() {
        labEquipmentTableView = labInfoView.labEquipmentTV
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

extension LabInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labEquipmentVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = labEquipmentTableView?.dequeueReusableCell(withIdentifier: ReuseId.labEquipmentCell) as! LabEquipmentTVCell
        let vm = labEquipmentVMs[indexPath.row]
        cell.equipmentNameLbl.text = vm.equipmentName
        cell.quantityLbl.text = "Quantity: \(vm.quantity)"
        return cell
    }
}
