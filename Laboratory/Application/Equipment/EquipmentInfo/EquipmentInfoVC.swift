//
//  EquipmentInfoVC.swift
//  Laboratory
//
//  Created by Developers on 5/16/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class EquipmentInfoVC: UIViewController, UIScrollViewDelegate, SpinnerPresentable, AlertPresentable {
    
    let spinnerVC = SpinnerViewController()
    
    private var viewModel = EquipmentInfoVM()
    var equipmentId: String?
    var isEditingEquipment = false
    
    @IBOutlet var topView: UIView!
    @IBOutlet private var scrollView: UIScrollView!
    private var equipmentInfoView: EquipmentInfoView!
    private var editSaveBtn: UIBarButtonItem!
    private var availableTextField: UITextField!
    private var nameTextView: UITextView!
    private var locationTextView: UITextView!
    private var descriptionTextView: UITextView!
    private var imageView: UIImageView!
    private var addImageButton: UIButton!
    private var removeEquipmentButton: UIButton!
    private var listOfUserButton: UIButton!
    
    private var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapRecognizer()
        addEquipmentInfoView()
        setupUI()
        if equipmentId != nil {
            showSpinner()
            loadEquipmentInfo()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.showEquipmentUserListFromEquipment {
            let equipmentUserListVC = segue.destination as! EquipmentUserListVC
            equipmentUserListVC.equipmentId = sender as? String
        }
    }
    
    // MARK: - Layout
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }
    
    private func addEquipmentInfoView() {
        equipmentInfoView = EquipmentInfoView.instantiate()
        scrollView.addSubview(equipmentInfoView)
        
        equipmentInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraintHeight = equipmentInfoView.heightAnchor.constraint(equalTo: topView.heightAnchor, constant: 0)
        constraintHeight.priority = UILayoutPriority(rawValue: 250)
        NSLayoutConstraint.activate([
            equipmentInfoView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            equipmentInfoView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            equipmentInfoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            equipmentInfoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            
            equipmentInfoView.widthAnchor.constraint(equalTo: topView.widthAnchor, constant: 0),
            constraintHeight
            ])
    }
    
    private func setupUI() {
        editSaveBtn = UIBarButtonItem(title: "Request an Edit", style: .plain, target: self, action: #selector(editSaveButtonTapped))
        navigationItem.rightBarButtonItem = editSaveBtn
        
        availableTextField = equipmentInfoView.availableTextField
        nameTextView = equipmentInfoView.nameTextView
        locationTextView = equipmentInfoView.locationTextView
        descriptionTextView = equipmentInfoView.descriptionTextView
        imageView = equipmentInfoView.equipmentImageView
        addImageButton = equipmentInfoView.addImageButton
        removeEquipmentButton = equipmentInfoView.removeEquipmentButton
        listOfUserButton = equipmentInfoView.listOfUserButton

        addImageButton.addTarget(self, action: #selector(editImage(_ :)), for: .touchUpInside)
        removeEquipmentButton.addTarget(self, action: #selector(attemptToRemoveEquipment), for: .touchUpInside)
        listOfUserButton.addTarget(self, action: #selector(showListOfUser), for: .touchUpInside)
        
        if equipmentId == nil {
            // TODO this does not work
            removeEquipmentButton.isHidden = true
            addImageButton.setTitle("Add Image", for: .normal)
            imageView.isHidden = true
        } else {
            addImageButton.setTitle("Edit Image", for: .normal)
        }
        
        updateUI(forEditing: isEditingEquipment)
        
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        addDelegates()
        addIdentifiers()
    }
    
    private func addDelegates() {
        scrollView.delegate = self
        availableTextField.delegate = self
        nameTextView.delegate = self
        descriptionTextView.delegate = self
        locationTextView.delegate = self
    }
    
    private func addIdentifiers() {
        editSaveBtn.accessibilityIdentifier = AccessibilityId.equipmentInfoEditSaveButton.description
        availableTextField.accessibilityIdentifier = AccessibilityId.equipmentInfoAvailableTextField.description
        nameTextView.accessibilityIdentifier = AccessibilityId.equipmentInfoNameTextView.description
        locationTextView.accessibilityIdentifier = AccessibilityId.equipmentInfoLocationTextView.description
        descriptionTextView.accessibilityIdentifier = AccessibilityId.equipmentInfoDescriptionTextView.description
        imageView.accessibilityIdentifier = AccessibilityId.equipmentInfoImageView.description
        addImageButton.accessibilityIdentifier = AccessibilityId.equipmentInfoAddImageButton.description
        removeEquipmentButton.accessibilityIdentifier = AccessibilityId.equipmentInfoRemoveEquipmentButton.description
        listOfUserButton.accessibilityIdentifier = AccessibilityId.equipmentInfoListOfUserButton.description
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
            if isEditingEquipment {
                // finish editing, save the new info to Firestore
                let newName = nameTextView.text!
                let newDescription = descriptionTextView.text!
                let newLocation = locationTextView.text!
                let newImageUrl = viewModel.getUrl(forImage: imageView.image!)
                let newAvailable = Int(availableTextField.text ?? "0")!
                viewModel.saveEquipment(withNewName: newName, newDescription: newDescription, newLocation: newLocation, newImageUrl: newImageUrl, newAvailable: newAvailable, equipmentId: equipmentId) { [weak self] (updateResult) in
                    guard let self = self else { return }
                    switch updateResult {
                    case let .failure(errorStr):
                        print(errorStr)
                        self.presentAlert(forCase: .failToSaveEquipment)
                    case .success:
                        self.goBackAndReload()
                    }
                }
            }
            updateUI(forEditing: !isEditingEquipment)
        }
        isEditingEquipment = !isEditingEquipment
    }
    
    @objc private func editImage(_ sender: UIButton) {
        imagePicker.present(from: sender)
    }
    
    @objc private func attemptToRemoveEquipment() {
        presentAlert(forCase: .attemptToRemoveEquipment, handler: removeEquipment)
    }
    
    private func removeEquipment(alert: UIAlertAction!) {
        viewModel.removeEquipment(withId: equipmentId) { [weak self] (deleteResult) in
            guard let self = self else { return }
            switch deleteResult {
            case let .failure(errorStr):
                print(errorStr)
                self.presentAlert(forCase: .failToRemoveEquipment)
            case .success:
                self.goBackAndReload()
            }
        }
    }
    
    @objc private func showListOfUser() {
        performSegue(withIdentifier: SegueId.showEquipmentUserListFromEquipment, sender: equipmentId)
    }
    
    private func goBack(alert: UIAlertAction!) {
        // go back to Equipment List View
        navigationController?.popViewController(animated: true)
    }
    
    private func goBackAndReload() {
        performSegue(withIdentifier: SegueId.unwindFromEquipmentInfo, sender: nil)
    }
}

// MARK: - Helper methods
extension EquipmentInfoVC {
    private var isInputInvalid: Bool {
        return availableTextField.text?.isEmpty ?? true ||
            nameTextView.text.isEmpty ||
            locationTextView.text.isEmpty ||
            descriptionTextView.text.isEmpty ||
            imageView.image == nil
    }
    
    private func updateUI(forEditing isBeingEdited: Bool) {
        editSaveBtn.title = isBeingEdited ? "Submit" : "Request an Edit"
        addImageButton.isHidden = !isBeingEdited
        if equipmentId != nil {
            removeEquipmentButton.isHidden = !isBeingEdited
        }
        listOfUserButton.isHidden = isBeingEdited
        availableTextField.updateEditingUI(forEditing: isBeingEdited)
        nameTextView.updateEditingUI(forEditing: isBeingEdited)
        locationTextView.updateEditingUI(forEditing: isBeingEdited)
        descriptionTextView.updateEditingUI(forEditing: isBeingEdited)
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

extension EquipmentInfoVC: ImagePickable {
    func didSelect(image: UIImage) {
        imageView.image = image
        imageView.isHidden = false
    }
}
