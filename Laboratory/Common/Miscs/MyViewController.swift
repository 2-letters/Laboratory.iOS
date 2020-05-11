//
//  MyViewController.swift
//  Laboratory
//
//  Created by Developers on 6/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

enum MyViewController: String {
    case homeTabBar = "HomeTabBarVC"
    case labCollection = "LabCollectionVC"
    case labInfo = "LabInfoVC"
    case labEquipmentSelection = "LabEquipmentSelectionVC"
    case labEquipmentEdit = "LabEquipmentEditVC"
    case equipmentList = "EquipmentListVC"
    case equipmentInfo = "EquipmentInfoVC"
    case equipmentUserList = "EquipmentUserListVC"
    
    case loginNavigation = "LoginNavigationVC"
    case login = "LoginVC"
    case signUp = "SignUpVC"
    case forgotPassword = "ForgotPasswordVC"
    var instance: UIViewController {
        var storyboard: UIStoryboard
        switch self {
            case .loginNavigation, .login, .signUp, .forgotPassword:
                storyboard = MyStoryboard.login.instance
            default:
                storyboard = MyStoryboard.main.instance
        }
        return storyboard.instantiateViewController(withIdentifier: self.rawValue)
    }
}
