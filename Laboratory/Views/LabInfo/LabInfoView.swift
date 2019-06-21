//
//  LabInfoView.swift
//  Laboratory
//
//  Created by Huy Vo on 5/12/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabInfoView: UIView {

//    @IBOutlet var contentView: UIView!
//    static let nibName = "LabInfoView"
    @IBOutlet var nameTextView: UITextView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var addEquipmentButton: UIButton!
    @IBOutlet var deleteLabButton: UIButton!
    @IBOutlet var labEquipmentTV: UITableView!
    
    static func instantiate() -> LabInfoView {
        let view: LabInfoView = initFromNib()
        return view
    }
}
