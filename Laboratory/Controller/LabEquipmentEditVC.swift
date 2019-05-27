//
//  LabEquipmentEditVC.swift
//  Laboratory
//
//  Created by Developers on 5/23/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabEquipmentEditVC: UIViewController, SpinnerPresenter {

    @IBOutlet var mainView: UIView!
    @IBOutlet private var usingQuantityTextField: UITextField!
    @IBOutlet private var decreaseBtn: UIButton!
    @IBOutlet private var increaseBtn: UIButton!
    @IBOutlet private var removeBtn: UIButton!
    @IBOutlet private var separatingLine: UIView!
    @IBOutlet private var equipmentInfoView: EquipmentInfoView!
    var spinnerVC = SpinnerViewController()
    
    private var equipmentInfoVM = EquipmentInfoVM()
    var equipmentName: String?
    // the original using quantiy
    var usingQuantity: Int = 0
    // the quantity being edited
    private var editingQuantity: Int = 0
    private var saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChange))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // hide view until loading is done
        mainView.isHidden = true
        showSpinner()
        setupUI()
    }
    
    // MARK: Layout
    func setupUI() {
        navigationItem.rightBarButtonItem = saveBtn
        saveBtn.isEnabled = false
        
        // quantity only accept numbers
        usingQuantityTextField.keyboardType = .numberPad
        usingQuantityTextField.textAlignment = .center
        editingQuantity = usingQuantity
        
        separatingLine.backgroundColor = Color.separatingLine
        
        updateUI()
        
        loadEquipmentInfo()
    }
    
    func updateUI() {
        // Quantity Layout
        usingQuantityTextField.text = String(editingQuantity)
        if editingQuantity == 0 {
            decreaseBtn.isEnabled = false
            removeBtn.isEnabled = false
        } else if editingQuantity == equipmentInfoVM.available {
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
    
    func loadEquipmentInfo() { equipmentInfoVM.fetchEquipmentInfo(byName: equipmentName!) { (fetchResult) in
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.updateEquipmentInfoLayout()
                }
            case .failure:
                // show an alert and return to the previous page
                let ac = UIAlertController(title: AlertString.oopsTitle, message: AlertString.tryAgainMessage, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: self.tryAgain))
                self.present(ac, animated: true, completion: nil)
            }
        }
    }
    
    private func updateEquipmentInfoLayout() {
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
        
        // show the view
        mainView.isHidden = false
        // hide spinner
        hideSpinner()
    }
    
    // MARK: User Interaction
    func tryAgain(alert: UIAlertAction!) {
        // go back to Equipment Selection
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveChange() {
        // TODO
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
}
