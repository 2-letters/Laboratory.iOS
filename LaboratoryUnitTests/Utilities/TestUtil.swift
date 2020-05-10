//
//  TestUtil.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

struct TestUtil {
    static func segues(ofViewController viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?
            .compactMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
}
