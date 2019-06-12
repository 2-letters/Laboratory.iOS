//
//  SpinnerPresentableTest.swift
//  LaboratoryUnitTests
//
//  Created by Huy Vo on 6/9/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

private class MockViewControllerForSpinnerPresentable: UIViewController, SpinnerPresentable {
    var spinnerVC = SpinnerViewController()
}

private class MockSpinnerVC: SpinnerViewController {
    var didMoveCalled = false
    override func didMove(toParent parent: UIViewController?) {
        didMoveCalled = true
    }
    
    var willMoveCalled = false
    override func willMove(toParent parent: UIViewController?) {
        willMoveCalled = true
    }
}

class SpinnerPresentableTest: XCTestCase {

    private var sut: MockViewControllerForSpinnerPresentable!
    private var mockSpinnerVC: MockSpinnerVC!
    override func setUp() {
        super.setUp()
        sut = MockViewControllerForSpinnerPresentable()
        mockSpinnerVC = MockSpinnerVC()
        sut.spinnerVC = mockSpinnerVC
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testShowSpinner() {
        // WHEN
        sut.showSpinner()
        
        // THEN
        XCTAssertTrue(sut.children.contains(mockSpinnerVC))
        XCTAssertTrue(mockSpinnerVC.view.frame == sut.view.frame)
        
        XCTAssertTrue(sut.view.subviews.contains(mockSpinnerVC.view))
        XCTAssertTrue(mockSpinnerVC.didMoveCalled)
    }
    
    func testHideSpinner() {
        // GIVEN
        let delayExpectation = expectation(description: "wait for 2 seconds")
        
        // WHEN
        sut.showSpinner()
        sut.hideSpinner()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            delayExpectation.fulfill()
        }
        
        // THEN
        waitForExpectations(timeout: 2.5)
        XCTAssertTrue(mockSpinnerVC.willMoveCalled)
        XCTAssertNil(mockSpinnerVC.view.superview)
        XCTAssertNil(mockSpinnerVC.parent)
    }
}
