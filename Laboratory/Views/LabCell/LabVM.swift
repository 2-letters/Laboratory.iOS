//
//  LabVM.swift
//  Laboratory
//
//  Created by Huy Vo on 5/26/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import Foundation

// For Lab TVCell
struct LabVM {
    var lab: Lab?
    
    var labId: String {
        return lab!.id
    }
    
    var labName: String {
        return lab!.name
    }
    
    var description: String {
        return lab!.description
    }
}
