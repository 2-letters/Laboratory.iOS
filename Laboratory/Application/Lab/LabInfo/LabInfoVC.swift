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
    private var isLabCreated: Bool = false
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
            loadLabEquipments()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isCreatingNewLab {
            navigationItem.title = MyString.labCreateTitle
            labInfoView.deleteLabButton.isHidden = true
        } else {
            navigationItem.title = MyString.labEditTitle
            labInfoView.deleteLabButton.isHidden = false
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
    private func addMainView() {
        labInfoView = LabInfoView.instantiate()
        labInfoView.removeFromSuperview()
        mainView.addSubview(labInfoView)
        labInfoView.frame = mainView.bounds
        labInfoView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func setupUI() {
        saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnPressed))
        navigationItem.rightBarButtonItem = saveBtn
        
        labInfoView.nameTextView.customize(isEditable: true)
        labInfoView.descriptionTextView.customize(isEditable: true)
        
        // register table cells
        labEquipmentTableView = labInfoView.labEquipmentTV
        let nib = UINib(nibName: LabEquipmentTVCell.nibId, bundle: nil)
        labEquipmentTableView.register(nib, forCellReuseIdentifier: LabEquipmentTVCell.reuseId)
        
        let addEquipmentButton = labInfoView.addEquipmentButton!
        if isCreatingNewLab {
            addEquipmentButton.setTitle("Add Equipments", for: .normal)
            addEquipmentButton.addTarget(self, action: #selector(addEquipments), for: .touchUpInside)
        } else {
            addEquipmentButton.setTitle("Edit Equipments", for: .normal)
            addEquipmentButton.addTarget(self, action: #selector(editEquipments), for: .touchUpInside)
        }
        
        addEquipmentButton.backgroundColor = MyColor.lightGreen
        addEquipmentButton.setTitleColor(UIColor.white, for: .normal)
        addEquipmentButton.titleLabel?.font = UIFont(name: secondaryFont, size: 17)
        
        let deleteLabButton = labInfoView.deleteLabButton!
        deleteLabButton.backgroundColor = MyColor.superLightGreen
        deleteLabButton.setTitleColor(MyColor.redWarning, for: .normal)
        deleteLabButton.titleLabel?.font = UIFont(name: secondaryFont, size: 17)
        
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
        mainView.accessibilityIdentifier = AccessibilityId.labInfoMainView.value
        saveBtn.accessibilityIdentifier = AccessibilityId.labInfoSaveButton.value
        labInfoView.nameTextView.accessibilityIdentifier = AccessibilityId.labInfoNameTextView.value
        labInfoView.descriptionTextView.accessibilityIdentifier = AccessibilityId.labInfoDescriptionTextView.value
        
        
        labInfoView.addEquipmentButton.accessibilityIdentifier = AccessibilityId.labInfoAddEquipmentButton.value
        labEquipmentTableView.accessibilityIdentifier = AccessibilityId.labInfoTableView.value
    }
    
    private func loadLabEquipments() {
        // start fetching Lab Equipments
        viewModel.fetchLabInfo(byId: labId, completion: { [weak self] (fetchResult) in
            guard let self = self else { return }
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.updateUI()
                    self.labEquipmentTableView?.reloadData()
                }
                self.hideSpinner()
            case let .failure(errorStr):
                print(errorStr)
                self.presentAlert(forCase: .failToLoadLabEquipments, handler: self.goBackAndReload)
            }
        })
    }
    
    private func updateUI() {
        // setup the Lab info views
        labInfoView.nameTextView.text = viewModel.labName
        labInfoView.descriptionTextView.text = viewModel.description
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
    
    private func tryToSaveLab(toAddEquipments: Bool) {
        let newLabName = labInfoView.nameTextView.text ?? ""
        let newLabDescription = labInfoView.descriptionTextView.text ?? ""

        
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

extension LabInfoVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        // there's some change, enable save Button
        
        saveBtn.isEnabled = true
        textView.highlight()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.unhighlight()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var textLimit = 0
        
        if textView == labInfoView.descriptionTextView {
            textLimit = 500
        } else if textView == labInfoView.nameTextView {
            textLimit = 100
        }
        
        return textView.text.count + text.count - range.length < textLimit
    }
}
