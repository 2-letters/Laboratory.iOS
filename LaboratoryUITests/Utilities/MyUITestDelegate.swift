//
//  MyUITestDelegate.swift
//  LaboratoryUITests
//
//  Created by Developers on 6/14/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

protocol UITestable {
    var app: XCUIApplication! { get set }
    // Switch taps
    func goToFirstTab()
    func goToSecondTab()
    
    // Switch view controllers
    func goToLabCollectionViewController()
    func goToLabCreate()
    func goToLabInfoViewController()
    func goToLabEquipmentSelectionViewController()
    func goToLabEquipmentEditViewController()
    func goToEquipmentListViewController()
    func goToEquipmentInfoViewController()
    
    // Interactions
    func tapOutside(inVC viewController: MyViewController)
    func swipeView(inVC viewController: MyViewController, toView destinationView: XCUIElement?)
    func getSearchBar(inVC viewController: MyViewController) -> XCUIElement?
    func getFirstCell(inVC viewController: MyViewController) -> XCUIElement?
    func proceedAlertButton(ofCase alertCase: AlertCase)
}

extension UITestable where Self: XCTestCase {
    // MARK: - Switch Tabs
    func goToFirstTab() {
        let tabBarButtons = XCUIApplication().tabBars.buttons
        tabBarButtons.element(boundBy: 0).tap()
    }
    
    func goToSecondTab() {
        let tabBarButtons = XCUIApplication().tabBars.buttons
        tabBarButtons.element(boundBy: 1).tap()
    }
    
    // MARK: - Switch View Controllers
    func goToLabCollectionViewController() {
        return
    }
    
    func goToLabCreate() {
        goToLabCollectionViewController()
        let addButton = app.buttons[AccessibilityId.labCollectionAddButton.description]
        addButton.tap()
    }
    
    func goToLabInfoViewController() {
        goToLabCollectionViewController()
        let firstCell = getFirstCell(inVC: .labCollection)!
        firstCell.tap()
    }
    func goToLabEquipmentSelectionViewController() {
        goToLabInfoViewController()
        let addEquipmentButton = app.buttons[AccessibilityId.labInfoAddEquipmentButton.description]
        addEquipmentButton.tap()
    }
    func goToLabEquipmentEditViewController() {
        goToLabEquipmentSelectionViewController()
        let firstCell = getFirstCell(inVC: .labEquipmentSelection)!
        firstCell.tap()
    }
    func goToEquipmentListViewController() {
        goToSecondTab()
    }
    func goToEquipmentInfoViewController() {
        goToEquipmentListViewController()
        let firstCell = getFirstCell(inVC: .equipmentList)!
        firstCell.tap()
    }
    
    
    // MARK: - Interactions
    func tapOutside(inVC viewController: MyViewController) {
        let mainView: XCUIElement
        switch viewController {
        case .labInfo:
            mainView = app.otherElements[AccessibilityId.labInfoMainView.description]
        case .labEquipmentEdit:
            mainView = app.scrollViews[AccessibilityId.labEquipmentEditScrollView.description]
        default:
            return
        }
        
        let coordinate = mainView.coordinate(withNormalizedOffset: CGVector.zero).withOffset(CGVector(dx: 10,dy: 1))
        coordinate.tap()
    }
    
    func swipeView(inVC viewController: MyViewController, toView destinationView: XCUIElement? = nil) {
        let view: XCUIElement
        switch viewController {
        case .labCollection:
            view = app.collectionViews[AccessibilityId.labCollectionView.description]
        case .labInfo:
            view = app.tables[AccessibilityId.labInfoTableView.description]
        case .labEquipmentSelection:
            view = app.tables[AccessibilityId.labEquipmentSelectionTableView.description]
        case .labEquipmentEdit:
            view = app.scrollViews[AccessibilityId.labEquipmentEditScrollView.description]
        case .equipmentList:
            view = app.tables[AccessibilityId.equipmentListTableView.description
            ]
        case .equipmentInfo:
            // todo fix this case, this is made up
            view = app.otherElements[AccessibilityId.equipmentInfoScrollView.description]
        }
//        let searchBar = getSearchBar(inVC: viewController)!
        if let destinationView = destinationView {
            view.cells.element(boundBy: 0).press(forDuration: 1, thenDragTo: destinationView)
        } else {
            view.swipeUp()
        }
    }
    
    func getSearchBar(inVC viewController: MyViewController) -> XCUIElement? {
        let searchBar: XCUIElement?
        switch viewController {
        case .labCollection:
            searchBar = app.otherElements[AccessibilityId.labCollectionSearchBar.description]
        case .labEquipmentSelection:
            searchBar = app.otherElements[AccessibilityId.labEquipmentSelectionSearchBar.description]
        case .equipmentList:
            searchBar = app.otherElements[AccessibilityId.equipmentListSearchBar.description]
        default:
            return nil
        }
        return searchBar
    }
    
    func getFirstCell(inVC viewController: MyViewController) -> XCUIElement? {
        switch viewController {
        case .labCollection:
            return app.collectionViews[AccessibilityId.labCollectionView.description].cells.element(boundBy: 0)
        case .labEquipmentSelection:
            return app.tables[AccessibilityId.labEquipmentSelectionTableView.description].cells.element(boundBy: 0)
        case .equipmentList:
            return app.tables[AccessibilityId.equipmentListTableView.description].cells.element(boundBy: 0)
        default:
            return nil
        }
    }
    
    func proceedAlertButton(ofCase alertCase: AlertCase) {
        let buttonText: String
        
        switch alertCase {
        case .invalidLabInfoInput,
             .succeedToSaveLab,
             .failToSaveLab,
             .failToRemoveLab,
             .failToLoadEquipments,
             .failToLoadLabEquipments,
             .failToLoadEquipmentInfo,
             .failToSaveEquipmentEdit:
            buttonText = AlertString.okay
            
        case .attemptCreateLabToAddEquipments,
             .attemptToRemoveLab:
            buttonText = AlertString.no
        }
        
        let alertButton = app.buttons[buttonText]
        alertButton.tap()
    }
}

typealias MyUITestDelegate = XCTestCase & UITestable