//
//  LabAssignmentSvc.swift
//  Laboratory
//
//  Created by Administrator on 5/8/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

class LabSvc {
    static func fetchData() -> [LabVM] {
        let labVMs = [
            LabVM(Lab(name: "lab1", description: "abc")),
            LabVM(Lab(name: "lab2", description: "abc2")),
        ]
        return labVMs
    }
    
    static func filter(with searchText: String) -> [LabVM] {
        let labAssignmentVMs = [
            LabVM(Lab(name: "lab1", description: "abc")),
            LabVM(Lab(name: "lab2", description: "abc2")),
            ]
        
        let searchedLabAssignmentVms = labAssignmentVMs
            .filter({$0.labName.lowercased()
                .prefix(searchText.count) == searchText.lowercased()})
        
        return searchedLabAssignmentVms
    }
}
