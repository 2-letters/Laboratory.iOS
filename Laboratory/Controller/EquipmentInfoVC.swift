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
    
    var equipmentName: String = "" {
        didSet {
            loadEquipmentInfo()
        }
    }
    
    var equipmentInfoVM: ItemVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    

    func loadEquipmentInfo() {
        ItemSvc.fetchItemInfo(byName: equipmentName) { [unowned self] (itemInfoResult) in
            switch itemInfoResult {
            case let .failure(errorStr):
                print(errorStr)
            case let .success(viewModel):
                self.equipmentInfoVM = viewModel
                self.updateUI()
            }
        }
    }
    
    private func updateUI() {
        mainView.availableLabel.text = "Available: \(equipmentInfoVM?.quantity)"
        mainView.nameLabel.text = "Name: \(equipmentInfoVM?.itemName ?? "")"
        mainView.locationTextView.text = equipmentInfoVM?.location
        adjustUITextViewHeight(arg: mainView.locationTextView)
        mainView.descriptionTextView.text = equipmentInfoVM?.description
        adjustUITextViewHeight(arg: mainView.descriptionTextView)
        do {
            let url = URL(string: equipmentInfoVM!.pictureUrl)!
            let data = try Data(contentsOf: url)
            mainView.equipmentImageView.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
//        mainView.equipmentImageView.image = UIImage(
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }

}
