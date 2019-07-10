//
//  LabCollectionViewControllerTest.swift
//  LaboratoryUnitTests
//
//  Created by Developers on 6/5/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class LabCollectionViewControllerTest: XCTestCase {

    var sut: LabCollectionVC!
    var labInfoVC: LabInfoVC!
    
    override func setUp() {
        super.setUp()
        
        sut = MyViewController.labCollection.instance as? LabCollectionVC
        labInfoVC = MyViewController.labInfo.instance as? LabInfoVC
        
        // Create the view
        let _ = sut.view
    }

    override func tearDown() {
        sut = nil
        labInfoVC = nil
        
        super.tearDown()
    }
    
    func testViewDidLoad() {
        // GIVEN
        let gestureRecognizers = sut.view.gestureRecognizers
        
        let navItem = sut.navigationItem
        
        // THEN
        XCTAssertEqual(gestureRecognizers?.count, 1)
        // test navigation bar
        XCTAssertEqual(navItem.title, "Labs")
        
        XCTAssertNotNil(navItem.rightBarButtonItem)
        XCTAssert(navItem.rightBarButtonItem?.target === sut)
        XCTAssertTrue(navItem.rightBarButtonItem?.action?.description == "createNewLab")
    }
    
    func testSearchBarDelegate() {
        XCTAssertTrue(sut.conforms(to: UISearchBarDelegate.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.searchBar(_:textDidChange:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.searchBarCancelButtonClicked(_:))))
    }
    
    func testCollectionView() {
        XCTAssertTrue(sut.conforms(to: UICollectionViewDelegate.self))
        XCTAssertTrue(sut.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(sut.conforms(to: UICollectionViewDelegateFlowLayout.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.collectionView(_:cellForItemAt:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.collectionView(_:didSelectItemAt:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.collectionView(_:layout:insetForSectionAt:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.collectionView(_:layout:sizeForItemAt:))))
    }
    
    // MARK: Segues
    func testSegueInfos() {
        // GIVEN
        let identifiers = TestUtil.segues(ofViewController: sut)
        
        // THEN
        XCTAssertEqual(identifiers.count, 1)
        XCTAssertTrue(identifiers.contains(SegueId.showLabInfo))
    }
    
    func testPassingDataToLabCreate() {
        // GIVEN
        let showLabCreateSegue = UIStoryboardSegue(identifier: SegueId.showLabInfo, source: sut, destination: labInfoVC)
        
        // WHEN
        sut.prepare(for: showLabCreateSegue, sender: "creatingNewInstance")
        
        // THEN
        XCTAssertTrue(labInfoVC.isCreatingNewLab)
        XCTAssertNil(labInfoVC.labId)
    }
    
    func testPassingDataToLabInfo() {
        // GIVEN
        let showLabInfoSegue = UIStoryboardSegue(identifier: SegueId.showLabInfo, source: sut, destination: labInfoVC)
        
        // WHEN
        sut.prepare(for: showLabInfoSegue, sender: FakeData.labId)
        
        // THEN
        XCTAssertFalse(labInfoVC.isCreatingNewLab)
        XCTAssertNotNil(labInfoVC.labId)
    }
    
    func testSearching() {
        // GIVEN
        let mockSearchBar = MockSearchBar()
        
        // WHEN
        sut.searchBarCancelButtonClicked(mockSearchBar)
        
        // THEN
        XCTAssertEqual(mockSearchBar.text, "")
    }
}
