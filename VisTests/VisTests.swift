//
//  VisTests.swift
//  VisTests
//
//  Created by Jim Boulter on 4/2/16.
//  Copyright © 2016 Squad. All rights reserved.
//

import XCTest
@testable import Vis

class VisTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //        Path.current = "/"
        let window = NSApplication.sharedApplication().mainWindow?.windowController
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        
        let browser_view_controller = storyboard.instantiateControllerWithIdentifier(" " ) as! NSViewController
        let browser_view = browser_view_controller.view
        
        testExample(browser_view)
        NSRunLoop.mainRunLoop().runUntilDate(NSDate())
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample(browser:NSView) {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print(browser.bounds)
        //        XCTAssertEqual(, <#T##expression2: [T : U]##[T : U]#>)
    }
    
    //    func testUIAlertViewShowsAfterViewLoads() {
    //        class FakeAlertView: NSAlertView {
    //            var showWasCalled = false
    //
    //            private func show() {
    //                showWasCalled = true
    //            }
    //        }
    //
    //        let vc = NSViewController()
    //        vc.alertView = FakeAlertView()
    //
    //        vc.viewDidLoad()
    //        XCTAssertTrue((vc.alertView as! FakeAlertView).showWasCalled, "Show was not called.")
    //    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
