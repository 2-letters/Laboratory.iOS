//
//  LabAssignmentViewModel.swift
//  Laboratory
//
//  Created by Administrator on 5/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

class LabAssignmentVM {
    var labAssignmentName: String
    
    init(assignment: LabAssignment) {
        self.labAssignmentName = assignment.name
    }
}
