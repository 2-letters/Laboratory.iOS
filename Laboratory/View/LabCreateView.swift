//
//  LabCreateView.swift
//  Laboratory
//
//  Created by Huy Vo on 5/12/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabCreateView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var descriptionTextField: UITextField!
    
    @IBOutlet var addItemsBtn: UIButton!
    
    @IBOutlet var labItemTV: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("LabCreateView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }

}
