//
//  LabAssignmentSvc.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

class LabAssignmentSvc {
    static func fetchData() -> [LabAssignmentVM] {
        let labAssignmentVMs = [
            LabAssignmentVM(assignment: LabAssignment(name: "lab1", description: "abc")),
            LabAssignmentVM(assignment: LabAssignment(name: "lab2", description: "abc2")),
        ]
        return labAssignmentVMs
    }
    
    static func filter(with searchText: String) -> [LabAssignmentVM] {
        let labAssignmentVMs = [
            LabAssignmentVM(assignment: LabAssignment(name: "lab1", description: "abc")),
            LabAssignmentVM(assignment: LabAssignment(name: "lab2", description: "abc2")),
            ]
        
        var searchedLabAssignmentVms = labAssignmentVMs
            .filter({$0.labAssignmentName
                .prefix(searchText.count) == searchText})
        
        return searchedLabAssignmentVms
    }
}
