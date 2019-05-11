//
//  LabAssignmentViewModel.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabVM {
    let labName: String
    let accessoryType: UITableViewCell.AccessoryType
    
    init(_ labInstance: Lab) {
        self.labName = labInstance.name
        accessoryType = .disclosureIndicator
    }
}
