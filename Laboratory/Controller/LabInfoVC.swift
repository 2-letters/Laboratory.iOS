//
//  LabInfoVC.swift
//  Laboratory
//
//  Created by Developers on 5/17/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabInfoVC: UIViewController {
    var labId: String!

    @IBOutlet private var labInfoView: LabInfoView!
    @IBOutlet private var saveBtn: UIBarButtonItem!
    
    private var labEquipmentTableView: UITableView!
    
    private var viewModel = LabInfoVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labEquipmentTableView = labInfoView.labEquipmentTV
        labEquipmentTableView.delegate = self
        labEquipmentTableView.dataSource = self
        labInfoView.nameTextField.delegate = self
        labInfoView.descriptionTextField.delegate = self
        
        setupUI()
        loadLabEquipments()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.editEquipments {
            let navC = segue.destination as! UINavigationController
            let labEquipmentSelectionVC = navC.viewControllers.first as! LabEquipmentSelectionVC
            labEquipmentSelectionVC.labId = labId
        }
    }
    
    @IBAction func unwindFromEquipmentSelection(segue: UIStoryboardSegue) {
        // there's some change, reload table view and enable save Button
        loadLabEquipments()
        saveBtn.isEnabled = true
    }
    
    
    // MARK: Layout
    func setupUI() {
        // get the Table View
        labEquipmentTableView = labInfoView.labEquipmentTV
        
        // change button title to "Edit Equipments..."
        labInfoView.addEquipmentsBtn.setTitle("Edit Equipments...", for: .normal)
        labInfoView.addEquipmentsBtn.addTarget(self, action: #selector(editEquipments), for: .touchUpInside)
        
        // disable Save button until some change is made
        saveBtn.isEnabled = false
        
        // register table cells
        let nib = UINib(nibName: "LabEquipmentTVCell", bundle: nil)
        labEquipmentTableView.register(nib, forCellReuseIdentifier: LabEquipmentTVCell.reuseId)
    }
    
    func loadLabEquipments() {
        // start fetching Lab Equipments
        viewModel.fetchLabInfo(byId: labId, completion: { (fetchResult) in
            switch fetchResult {
            case .success:
                self.updateUI()
                DispatchQueue.main.async {
                    self.labEquipmentTableView?.reloadData()
                }
            case let .failure(errorStr):
                print(errorStr)
            }
        })
    }
    
    func updateUI() {
        // setup the Lab info views
        labInfoView.nameTextField.text = viewModel.labName
        labInfoView.descriptionTextField.text = viewModel.description
    }
}


// MARK: - User Interaction
extension LabInfoVC {
    @objc func editEquipments() {
        performSegue(withIdentifier: SegueId.editEquipments, sender: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let newLabName = labInfoView.nameTextField.text!
        let newDescription = labInfoView.descriptionTextField.text!
        viewModel.updateLabInfo(byId: labId, withNewName: newLabName, newDescription: newDescription) { [unowned self] (fetchResult) in
            switch fetchResult {
            case let .failure(errorStr):
                print(errorStr)
            case .success:
                self.performSegue(withIdentifier: SegueId.unwindFromLabInfo, sender: nil)
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}


// MARK: - Table View
extension LabInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.equipmentVMs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = labEquipmentTableView?.dequeueReusableCell(withIdentifier: LabEquipmentTVCell.reuseId) as! LabEquipmentTVCell
        
        cell.viewModel = viewModel.equipmentVMs?[indexPath.row]
        return cell
    }
}


// MARK: Text Field
extension LabInfoVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // there's some change, enable save Button
        saveBtn.isEnabled = true
    }
}
