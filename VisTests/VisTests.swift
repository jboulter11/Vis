//
//  VisTests.swift
//  VisTests
//
//  Created by Jim Boulter on 4/2/16.
//  Copyright © 2016 Squad. All rights reserved.
//

import XCTest
import CoreData
@testable import Vis

class VisTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //        print(storyboard)
        //        XCTAssert(VSBrowserViewController. , "pass")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVis() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let visualization = VSVisualizationViewController.init()
        
        XCTAssertNotNil(visualization)
    }
    
    func testBrowser() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let browser = VSBrowserViewController.init()
        
        XCTAssertNotNil(browser)
    }
    
    func testInfo() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let info = VSInfoViewController.init()
        XCTAssertNotNil(info)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
