//
//  VisUITests.swift
//  VisUITests
//
//  Created by Jim Boulter on 4/2/16.
//  Copyright © 2016 Squad. All rights reserved.
//

import XCTest

class VisUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPDFDirectory() {
        
        let elementsQuery = XCUIApplication().windows["Vis"].browsers.scrollViews.otherElements
        elementsQuery.staticTexts["Test Directory"].click()
        elementsQuery.staticTexts["PDF Files"].click()
        elementsQuery.staticTexts["Algorithm Design - Jon Kleinberg and Eva Tardos, Tsinghua Univer"].click()
        
        XCTAssert(elementsQuery.staticTexts["Algorithm Design - Jon Kleinberg and Eva Tardos, Tsinghua Univer"].exists);
        
    }
    
    func testTextDirectory() {
        
        let elementsQuery = XCUIApplication().windows["Vis"].browsers.scrollViews.otherElements
        elementsQuery.staticTexts["Test Directory"].click()
        elementsQuery.staticTexts["Text Files"].click()
        elementsQuery.staticTexts["Vision.txt"].click()
        
        XCTAssert(elementsQuery.staticTexts["Vision.txt"].exists)
        
    }
    
    func testPictureDirectory() {
        
        let visWindow = XCUIApplication().windows["Vis"]
        visWindow.click()
        visWindow.click()
        
        let elementsQuery = visWindow.browsers.scrollViews.otherElements
        elementsQuery.staticTexts["Test Directory"].click()
        elementsQuery.staticTexts["Picture Files"].click()
        elementsQuery.staticTexts["Impression.jpg"].click()
        
        XCTAssert(elementsQuery.staticTexts["Impression.jpg"].exists)
    }
    
    func testPDFFileImage() {
        
        let visWindow = XCUIApplication().windows["Vis"]
        let elementsQuery = visWindow.browsers.scrollViews.otherElements
        elementsQuery.staticTexts["Test Directory"].click()
        elementsQuery.staticTexts["PDF Files"].click()
        elementsQuery.staticTexts["Algorithm Design - Jon Kleinberg and Eva Tardos, Tsinghua Univer"].click()
        XCTAssert(visWindow.childrenMatchingType(.SplitGroup).element.childrenMatchingType(.SplitGroup).element.childrenMatchingType(.Image).element.exists)
        
    }
    
    func testPDFFileInfo() {
        
        let visWindow = XCUIApplication().windows["Vis"]
        let elementsQuery = visWindow.browsers.scrollViews.otherElements
        elementsQuery.staticTexts["Test Directory"].click()
        elementsQuery.staticTexts["PDF Files"].click()
        elementsQuery.staticTexts["Algorithm Design - Jon Kleinberg and Eva Tardos, Tsinghua Univer"].click()
        visWindow.staticTexts["Portable Document Format"].rightClick()
        visWindow.staticTexts["5,975,786 Bytes"].click()
        
        XCTAssert(visWindow.staticTexts["Portable Document Format"].exists)
        XCTAssert(visWindow.staticTexts["5,975,786 Bytes"].exists)
        
    }
    
    func testPictureInfo() {
        
        let visWindow = XCUIApplication().windows["Vis"]
        let elementsQuery = visWindow.browsers.scrollViews.otherElements
        elementsQuery.staticTexts["Test Directory"].click()
        elementsQuery.staticTexts["Picture Files"].click()
        elementsQuery.staticTexts["Departure.png"].click()
        visWindow.childrenMatchingType(.SplitGroup).element.childrenMatchingType(.SplitGroup).element.childrenMatchingType(.Image).element.click()
        visWindow.staticTexts["PNG Image"].click()
        visWindow.staticTexts["1,318,965 Bytes"].click()
        
        XCTAssert(visWindow.childrenMatchingType(.SplitGroup).element.childrenMatchingType(.SplitGroup).element.childrenMatchingType(.Image).element.exists)
        XCTAssert(visWindow.staticTexts["PNG Image"].exists)
        XCTAssert(visWindow.staticTexts["1,318,965 Bytes"].exists)
        
    }
    
    func testTextInfo() {
        
        let visWindow = XCUIApplication().windows["Vis"]
        let elementsQuery = visWindow.browsers.scrollViews.otherElements
        elementsQuery.staticTexts["Test Directory"].click()
        elementsQuery.staticTexts["Text Files"].click()
        elementsQuery.staticTexts["Vision.txt"].click()
        visWindow.childrenMatchingType(.SplitGroup).element.childrenMatchingType(.SplitGroup).element.childrenMatchingType(.ScrollView).element.childrenMatchingType(.TextView).element.click()
        visWindow.staticTexts["Plain Text Document"].click()
        visWindow.staticTexts["2,468 Bytes"].click()
        
        XCTAssert(visWindow.childrenMatchingType(.SplitGroup).element.childrenMatchingType(.SplitGroup).element.childrenMatchingType(.ScrollView).element.childrenMatchingType(.TextView).element.exists)
        XCTAssert(visWindow.staticTexts["Plain Text Document"].exists)
        XCTAssert(visWindow.staticTexts["2,468 Bytes"].exists)
    }
    
    
}
