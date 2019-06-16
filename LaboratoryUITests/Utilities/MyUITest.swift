//
//  MyUITest.swift
//  LaboratoryUITests
//
//  Created by Developers on 6/14/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest

protocol UITestable {
    var app: XCUIApplication! { get set }
    func goToFirstTab()
    func goToSecondTab()
    func tapSearchBar(inVC viewController: MyViewController)
    func tapOutside()
    func swipeView(inVC viewController: MyViewController)
}

extension UITestable where Self: XCTestCase {
    func goToFirstTab() {
        let tabBarButtons = XCUIApplication().tabBars.buttons
        tabBarButtons.element(boundBy: 0).tap()
    }
    
    func goToSecondTab() {
        let tabBarButtons = XCUIApplication().tabBars.buttons
        tabBarButtons.element(boundBy: 1).tap()
    }
    
    func tapOutside() {
        //        let view: XCUIElement
        let normalized = app.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let coordinate = normalized.withOffset(CGVector(dx: 1, dy: 1))
        coordinate.tap()
        //        switch viewController {
        //        case .labCollection:
        //            view = app.collectionViews[AccessibilityId.labCollectionView.value]
        //        case .labInfo:
        //            view = app.tables[AccessibilityId.labInfoTableView.value]
        //        case .labEquipmentSelection:
        //            view = app.tables[AccessibilityId.labEquipmentSelectionTableView.value]
        //        case .labEquipmentEdit:
        //            view = app.tables[AccessibilityId.]
        //        case .equipmentList:
        //            view = app.tables[AccessibilityId.equipmentListTableView.value]
        //        case .equipmentInfo:
        ////            view = app.
        //        }
        //        view.tap()
    }
    
    func swipeView(inVC viewController: MyViewController) {
        let view: XCUIElement
        switch viewController {
        case .labCollection:
            view = app.collectionViews[AccessibilityId.labCollectionView.value]
        case .labInfo:
            <#code#>
        case .labEquipmentSelection:
            <#code#>
        case .labEquipmentEdit:
            <#code#>
        case .equipmentList:
            <#code#>
        case .equipmentInfo:
            <#code#>
        }
        view.swipeUp()
    }
    
    func tapSearchBar(inVC viewController: MyViewController) {
        let searchBar: XCUIElement?
        switch viewController {
        case .labCollection:
            searchBar = app.otherElements[AccessibilityId.labCollectionSearchBar.value]
        default:
            searchBar = nil
        }
        searchBar?.tap()
    }
    
    func typeTextSearchBar(inVC viewController: MyViewController) {
        let searchBar: XCUIElement?
        switch viewController {
        case .labCollection:
            searchBar = app.otherElements[AccessibilityId.labCollectionSearchBar.value]
        default:
            searchBar = nil
        }
        searchBar?.typeText("la")
    }
    
    func tryCancelSearchBar() {
        let cancelSearchBtn: XCUIElement?
        cancelSearchBtn = app/*@START_MENU_TOKEN@*/.otherElements["labCollectionSearchBar"].searchFields/*[[".otherElements[\"labCollectionSearchBar\"].searchFields",".searchFields"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.buttons["Clear text"]
        XCTAssertNotNil(cancelSearchBtn)
        XCTAssertTrue(cancelSearchBtn!.exists)
        cancelSearchBtn!.tap()
    }
    
    func tapFirstCell(inVC viewController: MyViewController) {
        let firstCell: XCUIElement?
        switch viewController {
        case .labCollection:
            firstCell = app.collectionViews["labCollectionSearchBar"].cells.element(boundBy: 0)
        default:
            firstCell = nil
        }
        firstCell?.tap()
    }
    
    func proceedAlertButton(ofAlert alert: XCUIElement) {
        let alertButton = app.buttons[alert.accessibilityValue!]
        alertButton.tap()
    }
}

typealias MyUITest = XCTestCase & UITestable
