//
//  LabEquipmentEditVC.swift
//  Laboratory
//
//  Created by Developers on 5/23/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabEquipmentEditVC: UIViewController {

    @IBOutlet var usingQuantityTextField: UITextField!
    @IBOutlet var decreaseBtn: UIButton!
    @IBOutlet var increaseBtn: UIButton!
    @IBOutlet var removeBtn: UIButton!
    @IBOutlet var equipmentInfoView: EquipmentInfoView!
    
    var equipmentInfoVM = EquipmentInfoVM()
    var equipmentName: String?
    // the original using quantiy
    var usingQuantity: Int = 0
    // the quantity being edited
    var editingQuantity: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: Layout
    func setupUI() {
        // quantity only accept numbers
        usingQuantityTextField.keyboardType = .numberPad
        usingQuantityTextField.textAlignment = .center
        editingQuantity = usingQuantity
        
        updateQuantityLayout()
        
        loadEquipmentInfo()
    }
    
    func updateQuantityLayout() {
        usingQuantityTextField.text = String(editingQuantity)
        if editingQuantity == 0 {
            decreaseBtn.isEnabled = false
        } else if editingQuantity == equipmentInfoVM.available {
            increaseBtn.isEnabled = false
        } else {
            decreaseBtn.isEnabled = true
            increaseBtn.isEnabled = true
        }
    }
    
    func loadEquipmentInfo() {
        equipmentInfoVM.fetchEquipmentInfo(byName: equipmentName!) { (fetchResult) in
            switch fetchResult {
            case .success:
                self.updateEquipmentInfoLayout()
            case .failure:
                // show an alert and return to the previous page
                let ac = UIAlertController(title: AlertString.failToLoadTitle, message: AlertString.tryAgainMessage, preferredStyle: .alert)
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
        //        mainView.equipmentImageView.image = UIImage(
    }
    
    // MARK: User Interaction
    @IBAction func decreaseEquipment(_ sender: UIButton) {
        editingQuantity -= 1
        updateQuantityLayout()
    }
    
    @IBAction func increaseEquipment(_ sender: UIButton) {
        editingQuantity += 1
        updateQuantityLayout()
    }
    
    @IBAction func removeEquipment(_ sender: UIButton) {
        // set quantity to 0
        editingQuantity = 0
        updateQuantityLayout()
    }
    
    func tryAgain(alert: UIAlertAction!) {
       // go back to Equipment Selection
        navigationController?.popViewController(animated: true)
    }
}
