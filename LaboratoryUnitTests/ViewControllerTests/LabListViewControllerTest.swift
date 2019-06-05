//
//  LabListViewControllerTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/5/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class LabListViewControllerTest: XCTestCase {

    var sut: LabListVC!
    override func setUp() {
        super.setUp()
        
        sut = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: StoryboardId.labListVC) as? LabListVC
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

    func testInitialLayouts() {
        XCTAssertNil(sut.labSearchBar)
        XCTAssertNil(sut.labCollectionView)
    }
    
    func testViewDidLoad() {
        // Create the view
        let _ = sut.view
        
        XCTAssertEqual(sut.navigationItem.title, "Labs")
        XCTAssertTrue(sut.labCollectionView.backgroundColor!.isEqual(Color.lightGray))

        XCTAssertTrue(sut.labCollectionView.delegate!.isEqual(sut))
        XCTAssertTrue(sut.labCollectionView.dataSource!.isEqual(sut))
        XCTAssertTrue(sut.labSearchBar.delegate!.isEqual(sut))
        
        let cell = sut.labCollectionView.dequeueReusableCell(withReuseIdentifier: LabCollectionViewCell.reuseId, for: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
        
        sut.re
//        // add refresh control
//        refreshControl.attributedTitle = NSAttributedString(string: "Loading Labs Data ...")
//        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
//        if #available(iOS 10.0, *) {
//            labCollectionView.refreshControl = refreshControl
//        } else {
//            labCollectionView.addSubview(refreshControl)
//        }
//
//        // "Create Lab" button
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewLab))
//        loadLabData()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
