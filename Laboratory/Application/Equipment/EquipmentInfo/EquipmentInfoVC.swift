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
        showSpinner()
        loadEquipmentInfo()
    }
    
    private func addMainView() {
        equipmentInfoView = EquipmentInfoView.instantiate()
        mainView.addSubview(equipmentInfoView)
        equipmentInfoView.frame = mainView.bounds
        equipmentInfoView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
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
        equipmentInfoView.availableLabel.text = viewModel.availableString
        equipmentInfoView.nameLabel.text = viewModel.equipmentName
        equipmentInfoView.locationTextView.text = viewModel.location
        LayoutUtil.adjustUITextViewHeight(arg: equipmentInfoView.locationTextView)
        equipmentInfoView.descriptionTextView.text = viewModel.description
        LayoutUtil.adjustUITextViewHeight(arg: equipmentInfoView.descriptionTextView)
        do {
            let url = URL(string: viewModel.pictureUrl)!
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
