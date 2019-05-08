//
//  LabTableViewCell.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabAssignmentTbVCell: UITableViewCell {

    @IBOutlet var labAssigmentNameLbl: UILabel!
    
    var courseViewModel: LabAssignmentVM! {
        didSet {
            labAssigmentNameLbl.text = courseViewModel.labAssignmentName
            accessoryType = courseViewModel.accessoryType
        }
    }
    
    @IBAction func LabAssignmentInfoBtn(_ sender: UIButton) {
    }
    
}
