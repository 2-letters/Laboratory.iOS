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
    
    var viewModel = LabEquipmentEditViewModel()
    var usingQuantity: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: Layout
    func setupUI() {
        // quantity only accept numbers
        usingQuantityTextField.keyboardType = .numberPad
        updateQuantityButtons()
    }
    
    func updateQuantityButtons() {
        if usingQuantity == 0 {
            decreaseBtn.isEnabled = false
        } else if usingQuantity == viewModel.equipmentInfoVM?.available {
            increaseBtn.isEnabled = false
        } else {
            decreaseBtn.isEnabled = true
            increaseBtn.isEnabled = true
        }
    }
    
    // MARK: User Interaction
    @IBAction func decreaseEquipment(_ sender: UIButton) {
//        usingQuantity -= 1
        updateQuantityButtons()
    }
    
    @IBAction func increaseEquipment(_ sender: UIButton) {
//        usingQuantity += 1
        updateQuantityButtons()
    }
    
    @IBAction func removeEquipment(_ sender: UIButton) {
        // set quantity to 0
        usingQuantity = 0
        usingQuantityTextField.text = String(0)
    }
}
