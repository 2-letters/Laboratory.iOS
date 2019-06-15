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
    var equipmentName: String?
    // the original using quantiy
    var usingQuantity: Int = 0
    // the quantity being edited

    @IBOutlet private var mainView: UIScrollView!
    @IBOutlet private var usingQuantityTextField: UITextField!
    @IBOutlet private var decreaseBtn: UIButton!
    @IBOutlet private var increaseBtn: UIButton!
    @IBOutlet private var removeBtn: UIButton!
    @IBOutlet private var separatingLine: UIView!
    @IBOutlet private var equipmentInfoViewContainer: UIView!
    private var equipmentInfoView: EquipmentInfoView!
    
    private var saveBtn: UIBarButtonItem!
    var spinnerVC = SpinnerViewController()
    private var viewModel = LabEquipmentEditVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTapRecognizer()
        addEquipmentInfoView()
        
        viewModel.usingQuantity = usingQuantity
        
        setupUI()
        showSpinner()
        loadEquipmentInfo()
    }
    
    
    // MARK: Layout
    private func addEquipmentInfoView() {
        equipmentInfoView = EquipmentInfoView.instantiate()
        equipmentInfoViewContainer.addSubview(equipmentInfoView)
        equipmentInfoView.frame = equipmentInfoViewContainer.bounds
        equipmentInfoView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func setupUI() {
        saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChange))
        navigationItem.rightBarButtonItem = saveBtn
        saveBtn.isEnabled = false
        
        // quantity only accept numbers
        usingQuantityTextField.keyboardType = .numberPad
        usingQuantityTextField.textAlignment = .center
        
        separatingLine.backgroundColor = Color.separatingLine
        
        usingQuantityTextField.delegate = self
        mainView.keyboardDismissMode = .onDrag
        addIdentifiers()
    }
    
    private func addIdentifiers() {
        saveBtn.accessibilityIdentifier = AccessibilityId.labEquipmentEditSaveButton.value
        usingQuantityTextField.accessibilityIdentifier = AccessibilityId.labEquipmentEditUsingQuantityTextField.value
        decreaseBtn.accessibilityIdentifier = AccessibilityId.labEquipmentEditDecreaseButton.value
        increaseBtn.accessibilityIdentifier = AccessibilityId.labEquipmentEditIncreaseButton.value
        removeBtn.accessibilityIdentifier = AccessibilityId.labEquipmentEditRemoveButton.value
        equipmentInfoView.nameLabel.accessibilityIdentifier = AccessibilityId.labEquipmentEditNameLabel.value
    }
    
    private func loadEquipmentInfo() {
        guard let equipmentName = equipmentName else {
            presentAlert(forCase: .failToLoadEquipmentInfo, handler: goBack(alert:))
            return
        }
        viewModel.equipmentInfoVM.fetchEquipmentInfo(byName: equipmentName) { [weak self] (fetchResult) in
            guard let self = self else { return }
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.updateEquipmentInfoLayout()
                }
            case .failure:
                // show an alert and return to the previous page
                self.presentAlert(forCase: .failToLoadEquipmentInfo, handler: self.goBack)
            }
        }
    }
    
    private func updateEquipmentInfoLayout() {
        let equipmentInfoVM = viewModel.equipmentInfoVM
        equipmentInfoView.availableLabel.text = equipmentInfoVM.availableString
        equipmentInfoView.nameLabel.text = equipmentInfoVM.equipmentName
        equipmentInfoView.locationTextView.text = equipmentInfoVM.location
        LayoutUtil.adjustUITextViewHeight(arg: equipmentInfoView.locationTextView)
        equipmentInfoView.locationTextView.isEditable = false
        equipmentInfoView.descriptionTextView.text = equipmentInfoVM.description
        LayoutUtil.adjustUITextViewHeight(arg: equipmentInfoView.descriptionTextView)
        equipmentInfoView.descriptionTextView.isEditable = false
        do {
            let url = URL(string: equipmentInfoVM.pictureUrl)!
            let data = try Data(contentsOf: url)
            equipmentInfoView.equipmentImageView.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        
        updateUI()
        // hide spinner
        hideSpinner()
    }
    
    private func updateUI() {
        // Quantity Layout
        usingQuantityTextField.text = String(viewModel.editingQuantity)
        
        decreaseBtn.isEnabled = viewModel.isDecreaseBtnEnabled
        increaseBtn.isEnabled = viewModel.isIncreaseBtnEnabled
        removeBtn.isEnabled = viewModel.isRemoveBtnEnabled
        
        saveBtn.isEnabled = viewModel.isSaveBtnEnabled 
    }
    
    
    // MARK: - User Interaction
    // MARK: Buttons
    @objc private func saveChange() {
        viewModel.updateEquipmentUsing(forLabId: labId, equipmentName: equipmentName!) { [weak self] (updateFirestoreResult) in
            guard let self = self else { return }
            switch updateFirestoreResult {
            case let .failure(errorStr):
                print(errorStr)
                // show an alert and return to the previous page
                self.presentAlert(forCase: .failToSaveEquipmentEdit)
            case .success:
                self.goBackAndReload()
            }
        }
    }
    
    @IBAction private func decreaseEquipment(_ sender: UIButton) {
        viewModel.editingQuantity -= 1
        updateUI()
    }
    
    @IBAction private func increaseEquipment(_ sender: UIButton) {
        viewModel.editingQuantity += 1
        updateUI()
    }
    
    @IBAction private func removeEquipment(_ sender: UIButton) {
        // set quantity to 0
        viewModel.editingQuantity = 0
        updateUI()
    }
    
    private func goBack(alert: UIAlertAction!) {
        // go back to Equipment Selection
        navigationController?.popViewController(animated: true)
    }
    
    private func goBackAndReload() {
        // go back to Equipment Selection
        performSegue(withIdentifier: SegueId.unwindFromEquipmentEdit, sender: nil)
    }
}

extension LabEquipmentEditVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.updateQuantityTextField(withText: textField.text)
        updateUI()
    }
}
