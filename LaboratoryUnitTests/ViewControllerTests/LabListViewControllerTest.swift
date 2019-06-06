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
    var labInfoVC: LabInfoVC!
    
    override func setUp() {
        super.setUp()
        
        sut = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: StoryboardId.labListVC) as? LabListVC
        labInfoVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: StoryboardId.labInfoVC) as? LabInfoVC
        
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
        let navItem = sut.navigationItem
        
        // THEN
        // test navigation bar
        XCTAssertEqual(navItem.title, "Labs")
        
        XCTAssertNotNil(navItem.rightBarButtonItem)
        XCTAssertNotNil(navItem.rightBarButtonItem?.target)
        XCTAssert(navItem.rightBarButtonItem?.target === sut)
        XCTAssertTrue(navItem.rightBarButtonItem?.action?.description == "createNewLab")
    }
    
    func testSearchBar() {
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
    func testSegueCount() {
        // GIVEN
        let identifiers = segues(ofViewController: sut)
        
        // THEN
        XCTAssertEqual(identifiers.count, 1)
        XCTAssertTrue(identifiers.contains(SegueId.showLabInfo))
    }
    
    func testShowLabCreateSegue() {
        // GIVEN
        class MockLabListVC: LabListVC {
            var segueIdentifierAndSender: (identifier: String, sender: String)?
            
            override func performSegue(withIdentifier identifier: String, sender: Any?) {
                segueIdentifierAndSender = (identifier, sender as! String)
            }
        }
        
        let mockLabListVC = MockLabListVC()
        
        // WHEN
        mockLabListVC.performSegue(withIdentifier: SegueId.showLabInfo, sender: CustomString.creatingNewInstanceFlag)
        
        // THEN
        // test identifier and sender
        XCTAssertEqual(mockLabListVC.segueIdentifierAndSender?.identifier, SegueId.showLabInfo)
        XCTAssertEqual(mockLabListVC.segueIdentifierAndSender?.sender, CustomString.creatingNewInstanceFlag)
    }
    
    func testPassingDataToLabCreate() {
        // GIVEN
        let showLabCreateSegue = UIStoryboardSegue(identifier: SegueId.showLabInfo, source: sut, destination: labInfoVC)
        
        // WHEN
        sut.prepare(for: showLabCreateSegue, sender: CustomString.creatingNewInstanceFlag)
        
        // THEN
        XCTAssertTrue(labInfoVC.isCreatingNewLab)
        XCTAssertNil(labInfoVC.labId)
    }
    
    func testSearching() {
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - Helpers
    func segues(ofViewController viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?
                            .compactMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
}

class SearchBarDouble: UISearchBar {
    
}
