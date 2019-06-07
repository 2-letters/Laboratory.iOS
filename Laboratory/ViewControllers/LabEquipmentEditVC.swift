//
//  LabEquipmentEditVC.swift
//  Laboratory
//
//  Created by Developers on 5/23/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabEquipmentEditVC: UIViewController, SpinnerPresenter {
    // to receive data from LabEquipmentSelectionVC
    var labId: String!
    var equipmentName: String?
    // the original using quantiy
    var usingQuantity: Int = 0
    // the quantity being edited

    @IBOutlet var mainView: UIView!
    @IBOutlet private var usingQuantityTextField: UITextField!
    @IBOutlet private var decreaseBtn: UIButton!
    @IBOutlet private var increaseBtn: UIButton!
    @IBOutlet private var removeBtn: UIButton!
    @IBOutlet private var separatingLine: UIView!
    @IBOutlet private var equipmentInfoView: EquipmentInfoView!
    
    private var saveBtn: UIBarButtonItem!
    internal var spinnerVC = SpinnerViewController()
    private var viewModel = LabEquipmentEditVM()

    private var editingQuantity: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usingQuantityTextField.delegate = self
        
        // hide view until loading is done
        mainView.isHidden = true
        showSpinner()
        setupUI()
        loadEquipmentInfo()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        mainView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    // MARK: Layout
    private func setupUI() {
        saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChange))
        navigationItem.rightBarButtonItem = saveBtn
        saveBtn.isEnabled = false
        
        // quantity only accept numbers
        usingQuantityTextField.keyboardType = .numberPad
        usingQuantityTextField.textAlignment = .center
        editingQuantity = usingQuantity
        
        separatingLine.backgroundColor = Color.separatingLine
    }
    
    private func loadEquipmentInfo() {
        viewModel.equipmentInfoVM.fetchEquipmentInfo(byName: equipmentName!) { (fetchResult) in
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.updateEquipmentInfoLayout()
                }
            case .failure:
                // show an alert and return to the previous page
                let ac = UIAlertController(title: AlertString.oopsTitle, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: self.goBack))
                self.present(ac, animated: true, completion: nil)
            }
        }
    }
    
    private func updateEquipmentInfoLayout() {
        let equipmentInfoVM = viewModel.equipmentInfoVM
        equipmentInfoView.availableLabel.text = equipmentInfoVM.availableString
        equipmentInfoView.nameLabel.text = equipmentInfoVM.equipmentName
        equipmentInfoView.locationTextView.text = equipmentInfoVM.location
        LayoutHelper.adjustUITextViewHeight(arg: equipmentInfoView.locationTextView)
        equipmentInfoView.locationTextView.isEditable = false
        equipmentInfoView.descriptionTextView.text = equipmentInfoVM.description
        LayoutHelper.adjustUITextViewHeight(arg: equipmentInfoView.descriptionTextView)
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
        // show the view
        mainView.isHidden = false
        // hide spinner
        hideSpinner()
    }
    
    private func updateUI() {
        // Quantity Layout
        usingQuantityTextField.text = String(editingQuantity)
        if editingQuantity == viewModel.available {
            decreaseBtn.isEnabled = true
            increaseBtn.isEnabled = false
            removeBtn.isEnabled = true
        } else if editingQuantity == 0 {
            decreaseBtn.isEnabled = false
            increaseBtn.isEnabled = true
            removeBtn.isEnabled = false
        } else {
            decreaseBtn.isEnabled = true
            increaseBtn.isEnabled = true
            removeBtn.isEnabled = true
        }
        // "Save" button is only enable when there's change in quantity
        saveBtn.isEnabled = editingQuantity != usingQuantity
    }
    
    
    // MARK: - User Interaction
    // MARK: Buttons
    @objc func saveChange() {
        viewModel.updateEquipmentUsing(forLabId: labId, equipmentName: equipmentName!, newUsing: editingQuantity) { [weak self] (updateFirestoreResult) in
            guard let self = self else { return }
            switch updateFirestoreResult {
            case let .failure(errorStr):
                print(errorStr)
                // show an alert and return to the previous page
                let ac = UIAlertController(title: AlertString.failToSaveEditTitle, message: AlertString.pleaseTryAgainLaterMessage, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: nil))
                self.present(ac, animated: true, completion: nil)
            case .success:
                self.goBackAndReload()
            }
        }
    }
    
    @IBAction func decreaseEquipment(_ sender: UIButton) {
        editingQuantity -= 1
        updateUI()
    }
    
    @IBAction func increaseEquipment(_ sender: UIButton) {
        editingQuantity += 1
        updateUI()
    }
    
    @IBAction func removeEquipment(_ sender: UIButton) {
        // set quantity to 0
        editingQuantity = 0
        updateUI()
    }
    
    func goBack(alert: UIAlertAction!) {
        // go back to Equipment Selection
        navigationController?.popViewController(animated: true)
    }
    
    func goBackAndReload() {
        // go back to Equipment Selection
        performSegue(withIdentifier: SegueId.unwindFromEquipmentEdit, sender: self)
    }
    
    @objc private func dismissKeyboard() {
        mainView.endEditing(true)
    }
}

extension LabEquipmentEditVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        var inputedQuantity = Int(textField.text ?? "0") ?? 0
        let availableQuantity = viewModel.available
        if inputedQuantity > availableQuantity {
            inputedQuantity = availableQuantity
        }
        editingQuantity = inputedQuantity
        updateUI()
    }
}
