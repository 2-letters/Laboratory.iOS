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
            labInfoVM = LabInfoVM(name: labName)
        }
    }
    var labInfoVM: LabInfoVM?
    var fetchLabEquipmentHandler: FetchLabEquipmentHandler?
    
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
        fetchLabEquipmentHandler = { [unowned self] (labEquipmentResult) in
            switch labEquipmentResult {
            case let .failure(errorStr):
                print(errorStr)
            case let .success(labInfo):
                self.labInfoVM? = LabInfoVM(labInfo: labInfo)
                // successfully fetch lab equipments data, load the labels
                self.loadLabels()
                // and reload the table view
                self.labEquipmentTableView?.reloadData()
            }
        }
        
        labInfoVM?.fetchLabEquipment(byName: labName, completion: fetchLabEquipmentHandler!)
    }
    
    func loadLabels() {
        // setup the Lab info views
        labInfoView.nameTextField.text = labInfoVM?.labName
        labInfoView.descriptionTextField.text = labInfoVM?.description
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.editEquipments {
            let labEquipmentSelectionVC = segue.destination as! LabEquipmentSelectionVC
            guard let addedEquipments = sender as? [String] else {
                return
            }
            labEquipmentSelectionVC.addedEquipments = addedEquipments
        }
    }
}


// MARK: - User Interaction
extension LabInfoVC {
    @objc func editEquipments() {
        guard let equipmentVMs = labInfoVM?.equipmentVMs else {
            return
        }
        let addedEquipments = equipmentVMs.map { $0.equipmentName }
        
        performSegue(withIdentifier: SegueId.editEquipments, sender: addedEquipments)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let labEquipmentSelectionVC = storyboard.instantiateViewController(withIdentifier: "labEquipmentSelectionVC")
//        let navController = UINavigationController(rootViewController: labEquipmentSelectionVC)
//        present(navController, animated: true, completion: nil)
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
        return labInfoVM?.equipmentVMs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = labEquipmentTableView?.dequeueReusableCell(withIdentifier: ReuseId.labEquipmentCell) as! LabEquipmentTVCell
        let vm = labInfoVM?.equipmentVMs?[indexPath.row]
        cell.equipmentNameLbl.text = vm?.equipmentName
        cell.quantityLbl.text = vm?.quantity
        return cell
    }
}
