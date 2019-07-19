//
//  EquipmentInfoVC.swift
//  Laboratory
//
//  Created by Developers on 5/16/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let didEditEquipment = Notification.Name(rawValue: "didEditEquipment")
}

class EquipmentInfoVC: UIViewController, UIScrollViewDelegate, SpinnerPresentable, AlertPresentable {
    
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
    private var deleteEquipmentButton: UIButton!
    private var listOfUserButton: UIButton!
    
    let spinnerVC = SpinnerViewController()
    private lazy var imagePicker: ImagePicker = {
        return ImagePicker(presentationController: self, delegate: self)
    }()
    
    private var viewModel = EquipmentInfoVM()
    private let showEquipmentUserListFromEquipmentSegue = "showEquipmentUserListFromEquipment"
    private let unwindFromEquipmentInfoSegue = "unwindFromEquipmentInfo"
    var equipmentId: String?
    var isEditingEquipment = false
    
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
    
    deinit {
        print("vox-deinit equipmentInfoVC")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showEquipmentUserListFromEquipmentSegue {
            let equipmentUserListVC = segue.destination as! EquipmentUserListVC
            equipmentUserListVC.equipmentId = sender as? String
        }
    }
    
    // MARK: - Layout
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    private func addEquipmentInfoView() {
        if equipmentId == nil {
            equipmentInfoView = EquipmentInfoView.instantiate(forCase: .equipmentCreate)
        } else {
            equipmentInfoView = EquipmentInfoView.instantiate(forCase: .equipmentInfo)
        }
        
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
        editSaveBtn = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(editSubmitButtonTapped))
        navigationItem.rightBarButtonItem = editSaveBtn
        
        availableTextField = equipmentInfoView.availableTextField
        nameTextView = equipmentInfoView.nameTextView
        locationTextView = equipmentInfoView.locationTextView
        descriptionTextView = equipmentInfoView.descriptionTextView
        imageView = equipmentInfoView.equipmentImageView
        addImageButton = equipmentInfoView.addImageButton
        deleteEquipmentButton = equipmentInfoView.deleteEquipmentButton
        listOfUserButton = equipmentInfoView.listOfUserButton

        if equipmentId != nil {
            equipmentInfoView.update(forEditing: false)
            editSaveBtn.title = "Request an Edit"
        }
        
        addImageButton.addTarget(self, action: #selector(editImage(_ :)), for: .touchUpInside)
        deleteEquipmentButton.addTarget(self, action: #selector(attemptToDeleteEquipment), for: .touchUpInside)
        listOfUserButton.addTarget(self, action: #selector(showListOfUser), for: .touchUpInside)
        
//        imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        addDelegates()
        addIdentifiers()
    }
    
    private func addDelegates() {
        scrollView.delegate = self
        availableTextField.delegate = self
        nameTextView.delegate = self
        descriptionTextView.delegate = self
        locationTextView.delegate = self
//        scrollView.keyboardDismissMode = .onDrag
    }
    
    private func addIdentifiers() {
        scrollView.accessibilityIdentifier = AccessibilityId.equipmentInfoScrollView.description
        editSaveBtn.accessibilityIdentifier = AccessibilityId.equipmentInfoEditSaveButton.description
    }

    private func loadEquipmentInfo() {
        viewModel.fetchEquipmentInfo(byId: equipmentId!) { [weak self] (fetchResult) in
            guard let self = self else { return }
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.equipmentInfoView.viewModel = self.viewModel
                    self.hideSpinner()
                }
            case let .failure(errorStr):
                print(errorStr)
                // show an alert and return to the previous page
                self.presentAlert(forCase: .failToLoadEquipmentInfo, handler: self.goBack)
            }
        }
    }
}

// MARK: - User Interaction
extension EquipmentInfoVC {
    @objc private func editSubmitButtonTapped() {
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
                        return
                    case .success:
                        self.presentAlert(forCase: .succeedToSaveEquipment, handler: { action in
                            self.goBackAndReload()
                        })
                    }
                }
            } else {
                // switch to edit
                isEditingEquipment = true
                equipmentInfoView.update(forEditing: true)
                editSaveBtn.title = "Submit"
            }
        }
    }
    
    @objc private func editImage(_ sender: UIButton) {
        imagePicker.present(from: sender)
    }
    
    @objc private func attemptToDeleteEquipment() {
        presentAlert(forCase: .attemptToDeleteEquipment, handler: deleteEquipment)
    }
    
    private func deleteEquipment(alert: UIAlertAction!) {
        viewModel.deleteEquipment(withId: equipmentId) { [weak self] (deleteResult) in
            guard let self = self else { return }
            switch deleteResult {
            case let .failure(errorStr):
                print(errorStr)
                self.presentAlert(forCase: .failToDeleteEquipment)
            case .success:
                self.goBackAndReload()
            }
        }
    }
    
    @objc private func showListOfUser() {
        performSegue(withIdentifier: showEquipmentUserListFromEquipmentSegue, sender: equipmentId)
    }
    
    private func goBack(alert: UIAlertAction!) {
        // go back to Equipment List View
        navigationController?.popViewController(animated: true)
    }
    
    private func goBackAndReload() {
        performSegue(withIdentifier: unwindFromEquipmentInfoSegue, sender: nil)
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
