//
//  AppDelegateTest.swift
//  LaboratoryUnitTests
//
//  Created by Huy Vo on 6/22/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import XCTest
@testable import Laboratory

class AppDelegateTest: XCTestCase {

    var sut: AppDelegate!
    var app: UIApplication!
    override func setUp() {
        super.setUp()
        sut = AppDelegate()
        app = UIApplication.shared
    }

    override func tearDown() {
        sut = nil
        app = nil
        super.tearDown()
    }

    func testAppDelegate() {
        sut.applicationWillResignActive(app)
        sut.applicationDidEnterBackground(app)
        sut.applicationWillEnterForeground(app)
        sut.applicationDidBecomeActive(app)
        sut.applicationWillTerminate(app)
    }

}
