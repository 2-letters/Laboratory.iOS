//
//  EquipmentInfoVC.swift
//  Laboratory
//
//  Created by Developers on 5/16/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class EquipmentInfoVC: UIViewController {
    
    @IBOutlet var mainView: EquipmentInfoView!

    var equipmentName: String?
    var equipmentInfoVM = EquipmentInfoVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadEquipmentInfo()
    }
    

    func loadEquipmentInfo() {
        equipmentInfoVM.fetchEquipmentInfo(byName: equipmentName!) { (fetchResult) in
            switch fetchResult {
            case .success:
                self.updateUI()
            case .failure:
                // show an alert and return to the previous page
                let ac = UIAlertController(title: AlertString.failToLoadTitle, message: AlertString.tryAgainMessage, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: AlertString.okay, style: .default, handler: self.tryAgain))
                self.present(ac, animated: true, completion: nil)
            }
        }
    }
    
    private func updateUI() {
        mainView.availableLabel.text = equipmentInfoVM.availableString
        mainView.nameLabel.text = equipmentInfoVM.equipmentName
        mainView.locationTextView.text = equipmentInfoVM.location
        LayoutHelper.adjustUITextViewHeight(arg: mainView.locationTextView)
        mainView.descriptionTextView.text = equipmentInfoVM.description
        LayoutHelper.adjustUITextViewHeight(arg: mainView.descriptionTextView)
        do {
            let url = URL(string: equipmentInfoVM.pictureUrl)!
            let data = try Data(contentsOf: url)
            mainView.equipmentImageView.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
    }
    
    func tryAgain(alert: UIAlertAction!) {
        // go back to Equipment List View
        navigationController?.popViewController(animated: true)
    }
}
