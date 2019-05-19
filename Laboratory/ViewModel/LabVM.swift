//
//  LabAssignmentViewModel.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

struct LabVM {
    let labName: String
    let description: String
    let accessoryType: UITableViewCell.AccessoryType
    
    init(_ labInstance: Lab) {
        self.labName = labInstance.name
        self.description = labInstance.description
        accessoryType = .disclosureIndicator
    }
}
