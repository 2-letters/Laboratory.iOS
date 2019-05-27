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
    
    var labEquipmentTableView: UITableView!
    
    var labName: String! {
        didSet {
            viewModel = LabInfoVM(name: labName)
        }
    }
    var viewModel: LabInfoVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labEquipmentTableView = labInfoView.labEquipmentTV
        labEquipmentTableView.delegate = self
        labEquipmentTableView.dataSource = self
        
        setupUI()
        loadLabEquipments()      
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
        labEquipmentTableView.register(nib, forCellReuseIdentifier: ReuseId.labEquipmentCell)
    }
    
    func loadLabEquipments() {
        // start fetching Lab Equipments
        viewModel?.fetchLabEquipment(byName: labName, completion: { (fetchResult) in
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
        labInfoView.nameTextField.text = viewModel?.labName
        labInfoView.descriptionTextField.text = viewModel?.description
    }
    
    // MARK: segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.editEquipments {
            let navC = segue.destination as! UINavigationController
            let labEquipmentSelectionVC = navC.viewControllers.first as! LabEquipmentSelectionVC
            guard let addedEquipmentVMs = sender as? [LabEquipmentVM] else {
                return
            }
            labEquipmentSelectionVC.addedEquipmentVMs = addedEquipmentVMs
        }
    }
}

// MARK: - User Interaction
extension LabInfoVC {
    @objc func editEquipments() {
        guard let equipmentVMs = viewModel?.equipmentVMs else {
            return
        }
        
        performSegue(withIdentifier: SegueId.editEquipments, sender: equipmentVMs)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        // TODO save the changes
    }
}

extension LabInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.equipmentVMs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = labEquipmentTableView?.dequeueReusableCell(withIdentifier: ReuseId.labEquipmentCell) as! LabEquipmentTVCell
        
        cell.viewModel = viewModel?.equipmentVMs[indexPath.row]
        return cell
    }
}
