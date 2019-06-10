//
//  LabInfoVC.swift
//  Laboratory
//
//  Created by Developers on 5/17/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

// for both LabInfoVC and LabCreateVC
class LabInfoVC: UIViewController, AlertPresentable {
    var isCreatingNewLab: Bool = false
    private var isLabCreated: Bool = false
    var labId: String?

    @IBOutlet private var mainView: UIView!
    private var labInfoView: LabInfoView!
    private var saveBtn: UIBarButtonItem!
    
    private var labEquipmentTableView: UITableView!
    private var viewModel = LabInfoVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnPressed))
        navigationItem.rightBarButtonItem = saveBtn
        
        setupMainView()
        // delegates
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isCreatingNewLab {
            navigationItem.title = "Create a Lab"
        } else {
            navigationItem.title = "Edit Lab"
        }
    }
    
    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.presentEquipmentSelection {
            let navC = segue.destination as! UINavigationController
            let labEquipmentSelectionVC = navC.viewControllers.first as! LabEquipmentSelectionVC
            labEquipmentSelectionVC.labId = labId
        }
    }
    
    @IBAction private func unwindFromEquipmentSelection(segue: UIStoryboardSegue) {
        // there's some change, reload table view and enable save Button
        isCreatingNewLab = false
        loadLabEquipments()
        saveBtn.isEnabled = true
    }
    
    // MARK: Layout
    private func setupMainView() {
        labInfoView = LabInfoView.instantiate()
        mainView.addSubview(labInfoView)
        labInfoView.frame = mainView.bounds
        labInfoView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func setupUI() {
        // register table cells
        let nib = UINib(nibName: LabEquipmentTVCell.nibId, bundle: nil)
        labEquipmentTableView.register(nib, forCellReuseIdentifier: LabEquipmentTVCell.reuseId)
        
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
    }
    
    private func loadLabEquipments() {
        // start fetching Lab Equipments
        viewModel.fetchLabInfo(byId: labId, completion: { [weak self] (fetchResult) in
            guard let self = self else { return }
            switch fetchResult {
            case .success:
                self.updateUI()
                DispatchQueue.main.async {
                    self.labEquipmentTableView?.reloadData()
                }
            case let .failure(errorStr):
                print(errorStr)
                self.presentAlert(forCase: .failToLoadLabEquipments, handler: self.goBackAndReload)
            }
        })
    }
    
    private func updateUI() {
        // setup the Lab info views
        labInfoView.nameTextField.text = viewModel.labName
        labInfoView.descriptionTextField.text = viewModel.description
    }
}


// MARK: - User Interaction
extension LabInfoVC {
    @objc private func editEquipments() {
        goToEquipmentsSelect()
    }
    
    @objc private func addEquipments() {
        if isLabCreated {
            goToEquipmentsSelect()
        } else {
            presentAlert(forCase: .createLabToAddEquipments, handler: createLabToAddEquipments)
        }
    }
    
    @objc private func saveBtnPressed() {
        tryToSaveLab(toAddEquipments: false)
    }
    
    private func createLabToAddEquipments(alert: UIAlertAction!) {
        tryToSaveLab(toAddEquipments: true)
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
    
    private func tryToSaveLab(toAddEquipments: Bool) {
        let newLabName = labInfoView.nameTextField.text ?? ""
        let newLabDescription = labInfoView.descriptionTextField.text ?? ""
        
        if (newLabName.isEmpty || newLabDescription.isEmpty) {
            presentAlert(forCase: .invalidLabInfoInput)
        } else {
            if isCreatingNewLab || toAddEquipments {
                // make sure lab Id is empty before creating
                labId = nil
            }
            viewModel.saveLab(withNewName: newLabName, newDescription: newLabDescription, labId: labId) { [weak self] (updateResult) in
                guard let self = self else { return }
                switch updateResult {
                case let .failure(errorStr):
                    print(errorStr)
                    self.presentAlert(forCase: .failToSaveLab)
                case let .success(newLabId):
                    if toAddEquipments {
                        self.isLabCreated = true
                        self.labId = newLabId
                        self.goToEquipmentsSelect()
                    } else {
                        self.presentAlert(forCase: .succeedToSaveLab, handler: self.goBackAndReload)
                    }
                }
            }
        }
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

extension LabInfoVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // there's some change, enable save Button
        saveBtn.isEnabled = true
    }
}
