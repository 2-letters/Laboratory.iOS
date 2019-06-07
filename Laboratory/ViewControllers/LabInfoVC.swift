//
//  LabInfoVC.swift
//  Laboratory
//
//  Created by Developers on 5/17/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

//protocol TapRecognizable {
//    var tapGestureRecognizer: UITapGestureRecognizer { get set }
//    func setupTapGestureRecognizer(view: UIView)
//    @objc func dismissKeyboard()
//}
//
//extension TapRecognizable where Self:UIViewController {
//    func setupTapGestureRecognizer(view: UIView) {
//        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//    }
//}

class TapRecognizableVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// for both LabInfoVC and LabCreateVC
class LabInfoVC: UIViewController {
    var isCreatingNewLab: Bool!
    var isLabCreated: Bool = false
    var labId: String?

    @IBOutlet private var labInfoView: LabInfoView!
    @IBOutlet private var saveBtn: UIBarButtonItem!
    
    private var labEquipmentTableView: UITableView!
    
    private var viewModel = LabInfoVM()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isCreatingNewLab {
            navigationItem.title = "Create a Lab"
        } else {
            navigationItem.title = "Edit Lab"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labEquipmentTableView = labInfoView.labEquipmentTV
        labEquipmentTableView.delegate = self
        labEquipmentTableView.dataSource = self
        labInfoView.nameTextField.delegate = self
        labInfoView.descriptionTextField.delegate = self
        
        setupUI()
        if !isCreatingNewLab {
            loadLabEquipments()
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.presentEquipmentSelection {
            let navC = segue.destination as! UINavigationController
            let labEquipmentSelectionVC = navC.viewControllers.first as! LabEquipmentSelectionVC
            labEquipmentSelectionVC.labId = labId
        }
    }
    
    @IBAction func unwindFromEquipmentSelection(segue: UIStoryboardSegue) {
        // there's some change, reload table view and enable save Button
        isCreatingNewLab = false
        loadLabEquipments()
        saveBtn.isEnabled = true
    }
    
    
    // MARK: Layout
    func setupUI() {
        // change button title to "Edit Equipments..."
        if isCreatingNewLab {
            labInfoView.addEquipmentsBtn.setTitle("Add Equipments ...", for: .normal)
            labInfoView.addEquipmentsBtn.addTarget(self, action: #selector(addEquipments), for: .touchUpInside)
        } else {
            labInfoView.addEquipmentsBtn.setTitle("Edit Equipments ...", for: .normal)
            labInfoView.addEquipmentsBtn.addTarget(self, action: #selector(editEquipments), for: .touchUpInside)
        }
        labInfoView.addEquipmentsBtn.backgroundColor = Color.lightGreen
        labInfoView.addEquipmentsBtn.setTitleColor(UIColor.white, for: .normal)
        
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
        goToEquipmentsSelect()
    }
    
    @objc func addEquipments() {
        if isLabCreated {
            goToEquipmentsSelect()
        } else {
            let ac = UIAlertController(title: AlertString.createLabRequiredTitle, message: AlertString.attemptToAddLabEquipmentsMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: createLabToAddEquipments))
            ac.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let newLabName = labInfoView.nameTextField.text ?? ""
        let newLabDescription = labInfoView.descriptionTextField.text ?? ""
        
        if (newLabName.isEmpty || newLabDescription.isEmpty) {
            warnInvalidInputs()
        } else {
            if isCreatingNewLab {
                // create a new lab on FireStore
                viewModel.createLab(withName: newLabName, description: newLabDescription) { [weak self] (createResult) in
                    guard let self = self else { return }
                    switch createResult {
                    case let .failure(errorStr):
                        print(errorStr)
                        self.alertFailToSaveLab()
                    case .success:
                        print("Successfully add a new lab: \(newLabName)")
                        self.alertSucceedToSaveLab()
                    }
                }
                dismiss(animated: true, completion: nil)
            } else {
                // update already existed Lab
                viewModel.updateLabInfo(byId: labId!, withNewName: newLabName, newDescription: newLabDescription) { [weak self] (fetchResult) in
                    guard let self = self else { return }
                    switch fetchResult {
                    case let .failure(errorStr):
                        print(errorStr)
                    case .success:
                        self.alertSucceedToSaveLab()
                    }
                }
            }
            
        }
    }
    
    private func createLabToAddEquipments(alert: UIAlertAction!) {
        let newLabName = labInfoView.nameTextField.text ?? ""
        let newLabDescription = labInfoView.descriptionTextField.text ?? ""
        
        if (newLabName.isEmpty || newLabDescription.isEmpty) {
            warnInvalidInputs()
        } else {
            viewModel.createLab(withName: newLabName, description: newLabDescription) { [weak self] (createResult) in
                guard let self = self else { return }
                switch createResult {
                case let .failure(errorStr):
                    print(errorStr)
                    self.alertFailToSaveLab()
                case let .success(labId):
                    self.isLabCreated = true
                    self.labId = labId
                    self.goToEquipmentsSelect()
                }
            }
        }
    }
    
    private func goBackAndReload(alert: UIAlertAction!) {
        self.performSegue(withIdentifier: SegueId.unwindFromLabInfo, sender: nil)
    }
    
    private func goToEquipmentsSelect() {
        performSegue(withIdentifier: SegueId.presentEquipmentSelection, sender: nil)
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


// MARK: - Text Field
extension LabInfoVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // there's some change, enable save Button
        saveBtn.isEnabled = true
    }
}


// MARK: - Helpers
extension LabInfoVC {
    private func warnInvalidInputs() {
        let ac = UIAlertController(title: AlertString.oopsTitle, message: AlertString.failToSaveLabInfoMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
    
    private func alertFailToSaveLab() {
        let ac = UIAlertController(title: AlertString.failToSaveLabTitle, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
    
    private func alertSucceedToSaveLab() {
        let ac = UIAlertController(title: AlertString.succeedToSaveLabTitle, message: AlertString.succeedToSaveLabMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: goBackAndReload))
        self.present(ac, animated: true, completion: nil)
        // call this on handler self.performSegue(withIdentifier: SegueId.unwindFromLabInfo, sender: nil)
    }
}
