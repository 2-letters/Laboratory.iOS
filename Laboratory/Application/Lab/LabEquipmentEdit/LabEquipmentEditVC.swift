//
//  LabEquipmentEditVC.swift
//  Laboratory
//
//  Created by Developers on 5/23/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabEquipmentEditVC: UIViewController, SpinnerPresentable, AlertPresentable {
    // to receive data from LabEquipmentSelectionVC
    var labId: String!
    var equipmentId: String!
    // the original using quantiy
    var usingQuantity: Int = 0
    // the quantity being edited

    @IBOutlet private var usingQuantityTextField: MyTextField!
    @IBOutlet private var decreaseButton: UIButton!
    @IBOutlet private var increaseButton: UIButton!
    @IBOutlet private var removeButton: UIButton!
    @IBOutlet private var separatingLine: UIView!
    @IBOutlet private var scrollView: UIScrollView!
    private var equipmentInfoView: EquipmentInfoView!
    
    private var saveBtn: UIBarButtonItem!
    var spinnerVC = SpinnerViewController()
    private let showEquipmentUserListFromLabSegue = "showEquipmentUserListFromLab"
    private let unwindFromEquipmentEditSegue = "unwindFromEquipmentEdit"
    private var viewModel: LabEquipmentEditVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTapRecognizer()
        addEquipmentInfoView()
        
        viewModel = LabEquipmentEditVM(usingQuantity: usingQuantity)
        
        setupUI()
        showSpinner()
        loadEquipmentInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showEquipmentUserListFromLabSegue {
            let equipmentUserListVC = segue.destination as! EquipmentUserListVC
            equipmentUserListVC.equipmentId = sender as? String
        }
    }
    
    
    // MARK: - Layout
    private func addEquipmentInfoView() {
        equipmentInfoView = EquipmentInfoView.instantiate(forCase: .equipmentInfoLabEdit)
        scrollView.addSubview(equipmentInfoView)
        
        setupEquipmentInfoViewConstraints()
    }
    
    private func setupEquipmentInfoViewConstraints() {
        equipmentInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            equipmentInfoView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            equipmentInfoView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            equipmentInfoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            equipmentInfoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            equipmentInfoView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0),
            equipmentInfoView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0),
            ])
    }
    
    private func setupUI() {
        saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChange))
        navigationItem.rightBarButtonItem = saveBtn
        saveBtn.isEnabled = false
        
        setupUsingQuantityTextField()
        setupQuantityButtons()
        
        separatingLine.backgroundColor = MyColor.lightGray

        equipmentInfoView.updateForViewOnly()
        equipmentInfoView.listOfUserButton.addTarget(self, action: #selector(showListOfUser), for: .touchUpInside)
        
        scrollView.keyboardDismissMode = .onDrag
        addIdentifiers()
    }
    
    private func setupUsingQuantityTextField() {
        // quantity only accept numbers
        usingQuantityTextField.keyboardType = .numberPad
        usingQuantityTextField.textAlignment = .center
        usingQuantityTextField.delegate = self
    }
    
    private func setupQuantityButtons() {
        decreaseButton.setTitleColor(MyColor.lightLavender, for: .normal)
        decreaseButton.setTitleColor(UIColor.gray, for: .disabled)
        increaseButton.setTitleColor(MyColor.lightLavender, for: .normal)
        removeButton.setTitleColor(MyColor.redWarning, for: .normal)
        removeButton.titleLabel?.font = UIFont(name: "GillSans", size: 17)
        removeButton.setTitleColor(UIColor.gray, for: .disabled)
    }
    
    private func addIdentifiers() {
        scrollView.accessibilityIdentifier = AccessibilityId.labEquipmentEditScrollView.description
        saveBtn.accessibilityIdentifier = AccessibilityId.labEquipmentEditSaveButton.description
        usingQuantityTextField.accessibilityIdentifier = AccessibilityId.labEquipmentEditUsingQuantityTextField.description
        decreaseButton.accessibilityIdentifier = AccessibilityId.labEquipmentEditDecreaseButton.description
        increaseButton.accessibilityIdentifier = AccessibilityId.labEquipmentEditIncreaseButton.description
        removeButton.accessibilityIdentifier = AccessibilityId.labEquipmentEditRemoveButton.description
    }
    
    private func loadEquipmentInfo() {
        guard let equipmentId = equipmentId else {
            presentAlert(forCase: .failToLoadEquipmentInfo, handler: goBack)
            return
        }
        
        viewModel.equipmentInfoVM.fetchEquipmentInfo(byId: equipmentId) { [weak self] (fetchResult) in
            guard let self = self else { return }
            switch fetchResult {
                
            case .success:
                self.handleSucceedFetchingEquipmentInfo()
                
            case .failure:
                // show an alert and return to the previous page
                self.presentAlert(forCase: .failToLoadEquipmentInfo, handler: self.goBack)
            }
        }
    }
    
    private func handleSucceedFetchingEquipmentInfo() {
        DispatchQueue.main.async {
            self.equipmentInfoView.viewModel = self.viewModel.equipmentInfoVM
            self.viewModel.updateButtonState()
            self.bindUI()
        }
        self.hideSpinner()
    }
    
    private func bindUI() {
        viewModel.editingQuantity.bindAndFire { [unowned self] in
            self.usingQuantityTextField.text = String($0)
        }
        viewModel.isDecreaseBtnEnabled.bindAndFire { [unowned self] in
            self.decreaseButton.isEnabled = $0
        }
        viewModel.isIncreaseBtnEnabled.bindAndFire { [unowned self] in
            self.increaseButton.isEnabled = $0
        }
        viewModel.isRemoveBtnEnabled.bindAndFire { [unowned self] in
            self.removeButton.isEnabled = $0
        }
        viewModel.isSaveBtnEnabled.bindAndFire { [unowned self] in
            self.saveBtn.isEnabled = $0
        }
    }
    
    
    // MARK: - User Interaction
    @objc private func saveChange() {
        viewModel.updateEquipmentUsing(forLabId: labId, equipmentId: equipmentId) { [weak self] (updateFirestoreResult) in
            guard let self = self else { return }
            switch updateFirestoreResult {
            case let .failure(errorStr):
                print(errorStr)
                // show an alert and return to the previous page
                self.presentAlert(forCase: .failToSaveEdit)
            case .success:
                self.goBackAndReload()
            }
        }
    }
    
    @IBAction private func decreaseEquipment(_ sender: UIButton) {
        viewModel.changeQuantity(by: .decrease)
    }
    
    @IBAction private func increaseEquipment(_ sender: UIButton) {
        viewModel.changeQuantity(by: .increase)
    }
    
    @IBAction private func deleteEquipment(_ sender: UIButton) {
        viewModel.changeQuantity(by: .remove)
    }
    
    // TODO: test this
    @objc private func showListOfUser() {
        performSegue(withIdentifier: showEquipmentUserListFromLabSegue, sender: equipmentId)
    }
    // TODO: test this
    private func goBack(alert: UIAlertAction!) {
        // go back to Equipment Selection
        navigationController?.popViewController(animated: true)
    }
    
    private func goBackAndReload() {
        // go back to Equipment Selection
        performSegue(withIdentifier: unwindFromEquipmentEditSegue, sender: nil)
    }
}

extension LabEquipmentEditVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usingQuantityTextField {
            usingQuantityTextField.highlight()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usingQuantityTextField {
            usingQuantityTextField.unhighlight()
        }
        viewModel.updateQuantityTextField(withText: textField.text)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inputLength = textField.text?.count ?? 0 + string.count - range.length
        return inputLength < (MyInt.quantityTextLimit + 1)
    }
}
