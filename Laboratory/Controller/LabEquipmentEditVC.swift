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
    var labName: String!
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
    private var hasChange: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // hide view until loading is done
        mainView.isHidden = true
        showSpinner()
        setupUI()
        loadEquipmentInfo()
    }
    
    
    // MARK: Navigation
    func goBack(alert: UIAlertAction!) {
        // go back to Equipment Selection
        navigationController?.popViewController(animated: true)
    }
    
    func goBackAndReload(alert: UIAlertAction!) {
        // go back to Equipment Selection
        performSegue(withIdentifier: SegueId.unwindFromEquipmentEdit, sender: self)
    }
    
    
    // MARK: Layout
    func setupUI() {
        saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChange))
        navigationItem.rightBarButtonItem = saveBtn
        saveBtn.isEnabled = false
        
        // quantity only accept numbers
        usingQuantityTextField.keyboardType = .numberPad
        usingQuantityTextField.textAlignment = .center
        editingQuantity = usingQuantity
        
        separatingLine.backgroundColor = Color.separatingLine
    }
    
    func loadEquipmentInfo() {
        viewModel.equipmentInfoVM.fetchEquipmentInfo(byName: equipmentName!) { (fetchResult) in
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.updateEquipmentInfoLayout()
                }
            case .failure:
                // show an alert and return to the previous page
                let ac = UIAlertController(title: AlertString.oopsTitle, message: AlertString.tryAgainMessage, preferredStyle: .alert)
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
        equipmentInfoView.descriptionTextView.text = equipmentInfoVM.description
        LayoutHelper.adjustUITextViewHeight(arg: equipmentInfoView.descriptionTextView)
        do {
            let url = URL(string: equipmentInfoVM.pictureUrl)!
            let data = try Data(contentsOf: url)
            equipmentInfoView.equipmentImageView.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        
        updateButtons()
        // show the view
        mainView.isHidden = false
        // hide spinner
        hideSpinner()
    }
    
    func updateButtons() {
        // Quantity Layout
        usingQuantityTextField.text = String(editingQuantity)
        if editingQuantity == 0 {
            decreaseBtn.isEnabled = false
            removeBtn.isEnabled = false
        } else if editingQuantity == viewModel.available {
            increaseBtn.isEnabled = false
            removeBtn.isEnabled = true
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
        viewModel.updateEquipmentUsing(forLab: labName, equipmentName: equipmentName!, newUsing: editingQuantity) { [unowned self] (updateFirestoreResult) in
            switch updateFirestoreResult {
            case let .failure(errorStr):
                print(errorStr)
                // show an alert and return to the previous page
                let ac = UIAlertController(title: AlertString.oopsTitle, message: AlertString.failToSaveLabEquipmentMessage, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: nil))
                self.present(ac, animated: true, completion: nil)
            case .success:
                // update this variable for unwind segue to determine when to reload data for Equipment Selection Table View
                self.hasChange = true
                
                let ac = UIAlertController(title: AlertString.successTitle, message: AlertString.succeedToSaveLabEquipmentMessage, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: self.goBackAndReload))
                self.present(ac, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func decreaseEquipment(_ sender: UIButton) {
        editingQuantity -= 1
        updateButtons()
    }
    
    @IBAction func increaseEquipment(_ sender: UIButton) {
        editingQuantity += 1
        updateButtons()
    }
    
    @IBAction func removeEquipment(_ sender: UIButton) {
        // set quantity to 0
        editingQuantity = 0
        updateButtons()
    }
}

//extension LabEquipmentEditVC: UITextFieldDelegate {
////    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
////        let currentUsingQuantity = Int(textField.text ?? "0")!
////
////        let availableQuantity = viewModel.available
////        if currentUsingQuantity > availableQuantity {
////            usingQuantityTextField.text = String(availableQuantity)
////        }
////        return true
////    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        let currentUsingQuantity = Int(textField.text ?? "0")!
//        let availableQuantity = viewModel.available
//        if currentUsingQuantity > availableQuantity {
//            textField.text = String(availableQuantity)
//        }
//    }
//}
