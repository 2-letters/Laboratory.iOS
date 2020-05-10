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
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var addEquipmentsBtn: UIButton!
    @IBOutlet var labEquipmentTV: UITableView!
    
    static func instantiate() -> LabInfoView {
        let view: LabInfoView = initFromNib()
        return view
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
//    func commonInit() {
//        Bundle.main.loadNibNamed("LabInfoView", owner: self, options: nil)
//        addSubview(contentView)
//        contentView.frame = self.bounds
//        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//    }

}
