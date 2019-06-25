//
//  EquipmentInfoVC.swift
//  Laboratory
//
//  Created by Developers on 5/16/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class EquipmentInfoVC: UIViewController, SpinnerPresentable, AlertPresentable {
    
    @IBOutlet private var mainView: UIView!
    private var equipmentInfoView: EquipmentInfoView!
    
    let spinnerVC = SpinnerViewController()

    var equipmentId: String?
    private var viewModel = EquipmentInfoVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapRecognizer()
        addMainView()
        setupUI()
        showSpinner()
        loadEquipmentInfo()
    }
    
    private func addMainView() {
        equipmentInfoView = EquipmentInfoView.instantiate()
        mainView.addSubview(equipmentInfoView)
        equipmentInfoView.frame = mainView.bounds
        equipmentInfoView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func setupUI() {
        
        addDelegates()
        addIdentifiers()
    }
    
    private func addDelegates() {
        equipmentInfoView.availableTextField.delegate = self
        equipmentInfoView.nameTextView.delegate = self
        equipmentInfoView.descriptionTextView.delegate = self
        equipmentInfoView.locationTextView.delegate = self
    }
    
    private func addIdentifiers() {
        
    }

    private func loadEquipmentInfo() {
        viewModel.fetchEquipmentInfo(byId: equipmentId!) { [weak self] (fetchResult) in
            guard let self = self else { return }
            switch fetchResult {
            case .success:
                DispatchQueue.main.async {
                    self.updateUI()
                }
            case let .failure(errorStr):
                print(errorStr)
                // show an alert and return to the previous page
                self.presentAlert(forCase: .failToLoadEquipmentInfo, handler: self.goBack)
            }
        }
    }
    
    private func updateUI() {
//        equipmentInfoView.availableTextView.text = viewModel.availableString
        equipmentInfoView.availableTextField.text = viewModel.availableString
        equipmentInfoView.nameTextView.customize(withText: viewModel.equipmentName, isEditable: false)
        
        equipmentInfoView.locationTextView.text = viewModel.location
        equipmentInfoView.descriptionTextView.text = viewModel.description
        do {
            let url = URL(string: viewModel.imageUrl)!
            let data = try Data(contentsOf: url)
            equipmentInfoView.equipmentImageView.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        
        // hide spinner
        hideSpinner()
    }
    
    func goBack(alert: UIAlertAction!) {
        // go back to Equipment List View
        navigationController?.popViewController(animated: true)
    }
}

extension EquipmentInfoVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.highlight()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.unhighlight()
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
        textView.unhighlight()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        var textLimit = 0
//
//        if textView == labInfoView.nameTextView {
//            textLimit = MyInt.nameTextLimit
//        } else if textView == labInfoView.descriptionTextView {
//            textLimit = MyInt.descriptionTextLimit
//        }
//
//        return textView.text.count + text.count - range.length < textLimit + 1
        return true
    }
}

