//
//  LabAssignmentViewModel.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

class LabAssignmentVM {
    let labAssignmentName: String
    let accessoryType: UITableViewCell.AccessoryType
    
    init(assignment: LabAssignment) {
        self.labAssignmentName = assignment.name
        accessoryType = .detailDisclosureButton
    }
}
