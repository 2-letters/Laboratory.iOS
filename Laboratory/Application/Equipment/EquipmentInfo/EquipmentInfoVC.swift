//
//  EquipmentInfoVC.swift
//  Laboratory
//
//  Created by Developers on 5/16/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class EquipmentInfoVC: UIViewController, SpinnerPresentable, AlertPresentable {
    
    let spinnerVC = SpinnerViewController()
    
    private var viewModel = EquipmentInfoVM()
    var equipmentId: String?
    var isEditingEquipment = false
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet private var mainView: UIView!
    private var equipmentInfoView: EquipmentInfoView!
    private var editSaveBtn: UIBarButtonItem!
    private var availableTextField: UITextField!
    private var nameTextView: UITextView!
    private var locationTextView: UITextView!
    private var descriptionTextView: UITextView!
    private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapRecognizer()
        addMainView()
        setupUI()
        showSpinner()
        loadEquipmentInfo()
    }
    
    // MARK: - Layout
    private func addMainView() {
        equipmentInfoView = EquipmentInfoView.instantiate()
        scrollView.contentSize = equipmentInfoView.frame.size
        scrollView.addSubview(equipmentInfoView)
//        equipmentInfoView.frame = mainView.bounds
//        equipmentInfoView.frame = scrollView.bounds
//        equipmentInfoView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
//        equipmentInfoView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        equipmentInfoView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        equipmentInfoView.translatesAutoresizingMaskIntoConstraints = false
    equipmentInfoView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        equipmentInfoView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        let equipmentInfoViewBottomConstraint = NSLayoutConstraint(item: equipmentInfoView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1.0, constant: 0.0)
//        NSLayoutConstraint constraintWithItem:self
//            attribute:NSLayoutAttributeHeight
//            relatedBy:NSLayoutRelationEqual
//            toItem:self.superview
//            attribute:NSLayoutAttributeHeight
//            multiplier:1
//            constant:0];
        equipmentInfoViewBottomConstraint.isActive = YES
        equipmentInfoViewBottomConstraint.priority = 250
    }
    
    private func setupUI() {
        editSaveBtn = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editSaveButtonTapped))
        navigationItem.rightBarButtonItem = editSaveBtn
        
        availableTextField = equipmentInfoView.availableTextField
        nameTextView = equipmentInfoView.nameTextView
        locationTextView = equipmentInfoView.locationTextView
        descriptionTextView = equipmentInfoView.descriptionTextView
        imageView = equipmentInfoView.equipmentImageView
        
        addDelegates()
        addIdentifiers()
    }
    
    private func addDelegates() {
        availableTextField.delegate = self
        nameTextView.delegate = self
        descriptionTextView.delegate = self
        locationTextView.delegate = self
    }
    
    private func addIdentifiers() {
        availableTextField.accessibilityIdentifier = AccessibilityId.equipmentInfoAvailableTextField.description
        nameTextView.accessibilityIdentifier = AccessibilityId.labInfoNameTextView.description
        descriptionTextView.accessibilityIdentifier = AccessibilityId.labInfoDescriptionTextView.description
        locationTextView.accessibilityIdentifier = AccessibilityId.equipmentInfoLocationTextView.description
    }

    private func loadEquipmentInfo() {
        viewModel.fetchEquipmentInfo(byId: equipmentId!) { [weak self] (fetchResult) in
            guard let self = self else { return }
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.loadUI()
                }
            case let .failure(errorStr):
                print(errorStr)
                // show an alert and return to the previous page
                self.presentAlert(forCase: .failToLoadEquipmentInfo, handler: self.goBack)
            }
        }
    }
    
    private func loadUI() {
        availableTextField.text = viewModel.availableString
        nameTextView.customize(withText: viewModel.equipmentName, isEditable: false)
        
        locationTextView.text = viewModel.location
        descriptionTextView.text = viewModel.description
        do {
            let url = URL(string: viewModel.imageUrl)!
            let data = try Data(contentsOf: url)
            imageView.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        
        // hide spinner
        hideSpinner()
    }
}

// MARK: - User Interaction
extension EquipmentInfoVC {
    @objc private func editSaveButtonTapped() {
        if isEditingEquipment && isInputInvalid {
            presentAlert(forCase: .invalidEquipmentInfoInput)
        } else {
            updateUI(forEditing: !isEditingEquipment)
        }
        isEditingEquipment = !isEditingEquipment
    }
    
    func goBack(alert: UIAlertAction!) {
        // go back to Equipment List View
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Helper methods
extension EquipmentInfoVC {
    var isInputInvalid: Bool {
        return availableTextField.text?.isEmpty ?? true ||
            nameTextView.text.isEmpty ||
            locationTextView.text.isEmpty ||
            descriptionTextView.text.isEmpty
    }
    
    func updateUI(forEditing isEditable: Bool) {
        editSaveBtn.title = isEditable ? "Save" : "Edit"
        availableTextField.updateEditingUI(forEditing: isEditable)
        nameTextView.updateEditingUI(forEditing: isEditable)
        locationTextView.updateEditingUI(forEditing: isEditable)
        descriptionTextView.updateEditingUI(forEditing: isEditable)
    }
}

extension EquipmentInfoVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.highlight()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.unhighlight()
        if textField.text?.isEmpty ?? true {
            textField.text = String(0)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inputLength = textField.text?.count ?? 0 + string.count - range.length
        return inputLength < (MyInt.quantityTextLimit + 1)
    }
}

extension EquipmentInfoVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
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
        
        if textView == nameTextView {
            textLimit = MyInt.nameTextLimit
        } else if textView == locationTextView {
            textLimit = MyInt.locationTextLimit
        } else if textView == descriptionTextView {
            textLimit = MyInt.descriptionTextLimit
        }
        
        return textView.text.count + text.count - range.length < textLimit + 1
    }
}

