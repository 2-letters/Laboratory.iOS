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
    var labName: String {
        return lab!.name
    }
    var labId: String {
        return lab!.id
    }
}
