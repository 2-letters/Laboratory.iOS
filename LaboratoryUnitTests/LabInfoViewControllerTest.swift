//
//  LabInfoViewControllerTest.swift
//  LaboratoryUnitTests
//
//  Created by Huy Vo on 6/7/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class LabInfoViewControllerTest: XCTestCase {

    var sut: LabInfoVC!
    override func setUp() {
        super.setUp()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryboardId.labInfoVC) as! LabInfoVC
//        let _ = sut.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testViewWillAppear() {
        // WHEN
        sut.isCreatingNewLab = true
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        // THEN
        XCTAssertEqual(sut.navigationItem.title, "Create a Lab")
        
        // WHEN
        sut.isCreatingNewLab = false
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        // THEN
        XCTAssertEqual(sut.navigationItem.title, "Edit Lab")
    }
    
    func testViewDidLoad() {
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
