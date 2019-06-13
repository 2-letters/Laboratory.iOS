//
//  EquipmentInfoView.swift
//  Laboratory
//
//  Created by Developers on 5/15/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

//protocol ViewInstantiatable {
//    func instantiate<T: UIView>() -> T
//}
//
//typealias MyView = UIView & ViewInstantiatable

class EquipmentInfoView: UIView {
//    static let nibName = "EquipmentInfoView"
    @IBOutlet var availableLabel: UILabel!
//    @IBOutlet var contentView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationTextView: UITextView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var equipmentImageView: UIImageView!
    
//    func instantiate<EquipmentInfoView>() -> EquipmentInfoView where EquipmentInfoView : UIView {
//        let view: EquipmentInfoView = .initFromNib()
//        return view
//    }
    
    static func instantiate() -> EquipmentInfoView {
        let view: EquipmentInfoView = initFromNib()
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
//        Bundle.main.loadNibNamed(EquipmentInfoView.nibName, owner: self, options: nil)
//        addSubview(contentView)
//        contentView.frame = self.bounds
//        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//    }
}
