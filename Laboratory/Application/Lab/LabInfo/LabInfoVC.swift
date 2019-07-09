//
//  LabInfoVC.swift
//  Laboratory
//
//  Created by Developers on 5/17/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

// for both LabInfoVC and LabCreateVC
class LabInfoVC: UIViewController, SpinnerPresentable, AlertPresentable {
    var isCreatingNewLab: Bool = false
    var labId: String?

    @IBOutlet private var mainView: UIView!
    
    var spinnerVC = SpinnerViewController()
    private var labInfoView: LabInfoView!
    private var saveBtn: UIBarButtonItem!
    private var labEquipmentTableView: UITableView!
    
    private var viewModel = LabInfoVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapRecognizer()
        
        addMainView()
        setupUI()
        
        if !isCreatingNewLab {
            showSpinner()
            loadLabInfo()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isCreatingNewLab {
            navigationItem.title = MyString.labCreateTitle
            labInfoView.removeLabButton.isHidden = true
        } else {
            navigationItem.title = MyString.labEditTitle
            labInfoView.removeLabButton.isHidden = false
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
        loadLabInfo()
        saveBtn.isEnabled = true
    }
    
    // MARK: Layout
    private func addMainView() {
        labInfoView = LabInfoView.instantiate()
        labInfoView.removeFromSuperview()
        mainView.addSubview(labInfoView)
        labInfoView.frame = mainView.bounds
        labInfoView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func setupUI() {
        saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveBtn
        
        // register table cells
        labEquipmentTableView = labInfoView.labEquipmentTV
        labEquipmentTableView.register(LabEquipmentTVCell.self)
//        let nib = UINib(nibName: LabEquipmentTVCell.nibId, bundle: nil)
//        labEquipmentTableView.register(nib, forCellReuseIdentifier: LabEquipmentTVCell.reuseId)
        
        let addEquipmentButton = labInfoView.addEquipmentButton!
        if isCreatingNewLab {
            addEquipmentButton.setTitle("Add Equipments", for: .normal)
            addEquipmentButton.addTarget(self, action: #selector(addEquipments), for: .touchUpInside)
        } else {
            addEquipmentButton.setTitle("Edit Equipments", for: .normal)
            addEquipmentButton.addTarget(self, action: #selector(editEquipments), for: .touchUpInside)
        }
        
        
        let removeLabButton = labInfoView.removeLabButton!
        removeLabButton.addTarget(self, action: #selector(attemptToRemoveLab), for: .touchUpInside)
        
        // disable Save button until some change is made
        saveBtn.isEnabled = false
        
        addDelegates()
        addIdentifiers()
    }
    
    private func addDelegates() {
        labEquipmentTableView.delegate = self
        labEquipmentTableView.dataSource = self
        labEquipmentTableView.keyboardDismissMode = .onDrag
        labInfoView.nameTextView.delegate = self
        labInfoView.descriptionTextView.delegate = self
    }
    
    private func addIdentifiers() {
        mainView.accessibilityIdentifier = AccessibilityId.labInfoMainView.description
        saveBtn.accessibilityIdentifier = AccessibilityId.labInfoSaveButton.description
    }
    
    private func loadLabInfo() {
        // start fetching Lab Equipments
        viewModel.fetchLabInfo(byId: labId, completion: { [weak self] (fetchResult) in
            guard let self = self else { return }
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    // updateUI
                    self.labInfoView.labInfoVM = self.viewModel
                    self.labEquipmentTableView?.reloadData()
                }
                self.hideSpinner()
            case let .failure(errorStr):
                print(errorStr)
                self.presentAlert(forCase: .failToLoadLabEquipments, handler: { action in
                    self.goBackAndReload()
                })
            }
        })
    }
}


// MARK: - User Interaction
extension LabInfoVC {
    private func goBackAndReload() {
        self.performSegue(withIdentifier: SegueId.unwindFromLabInfo, sender: nil)
    }
    
    private func goToEquipmentsSelect() {
        performSegue(withIdentifier: SegueId.presentEquipmentSelection, sender: nil)
    }
    
    @objc private func editEquipments() {
        goToEquipmentsSelect()
    }
    
    @objc private func addEquipments() {
        if isCreatingNewLab {
            let newLabName = labInfoView.nameTextView.text ?? ""
            let newLabDescription = labInfoView.descriptionTextView.text ?? ""
            
            if (newLabName.isEmpty || newLabDescription.isEmpty) {
                presentAlert(forCase: .invalidLabInfoInput)
            }
            
            presentAlert(forCase: .attemptCreateLab, handler: { action in
                self.attemptToSaveLab(toAddEquipments: true)
            })
        } else {
            goToEquipmentsSelect()
        }
    }
    
    @objc private func attemptToRemoveLab() {
        presentAlert(forCase: .attemptToRemoveLab, handler: removeLab)
    }
    
    private func removeLab(alert: UIAlertAction!) {
        viewModel.removeLab(withId: labId) { [weak self] (deleteResult) in
            guard let self = self else { return }
            switch deleteResult {
            case let .failure(errorStr):
                print(errorStr)
                self.presentAlert(forCase: .failToRemoveLab)
            case .success:
                self.goBackAndReload()
            }
        }
    }
    
    @objc private func saveButtonTapped() {
        attemptToSaveLab(toAddEquipments: false)
    }
    
    private func attemptToSaveLab(toAddEquipments: Bool) {
        let newLabName = labInfoView.nameTextView.text ?? ""
        let newLabDescription = labInfoView.descriptionTextView.text ?? ""

        
        if (newLabName.isEmpty || newLabDescription.isEmpty) {
            presentAlert(forCase: .invalidLabInfoInput)
        } else {
            if isCreatingNewLab || toAddEquipments {
                // make sure lab Id is empty if creating a new Lab
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
                        // Successfully created a new Lab, to add Equipments
                        self.isCreatingNewLab = false
                        self.labId = newLabId
                        self.goToEquipmentsSelect()
                    } else {
                        // Save this lab (either new or old), go back 
                        self.presentAlert(forCase: .succeedToSaveLab, handler: { action in
                            self.goBackAndReload()
                        })
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
        let cell: LabEquipmentTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
//        let cell = labEquipmentTableView?.dequeueReusableCell(withIdentifier: LabEquipmentTVCell.reuseId, for: indexPath) as! LabEquipmentTVCell
        
        cell.viewModel = viewModel.equipmentVMs?[indexPath.row]
        return cell
    }
}

extension LabInfoVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        // there's some change, enable save Button
        
        saveBtn.isEnabled = true
        textView.highlight()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.warnInput()
        } else {
            textView.unhighlight()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var textLimit = 0
        
        if textView == labInfoView.nameTextView {
            textLimit = MyInt.nameTextLimit
        } else if textView == labInfoView.descriptionTextView {
            textLimit = MyInt.descriptionTextLimit
        }
        
        return textView.text.count + text.count - range.length < textLimit + 1
    }
}
