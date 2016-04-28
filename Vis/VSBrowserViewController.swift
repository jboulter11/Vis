//
//  VSBrowserViewController.swift
//  Vis
//
//  Created by Jim Boulter on 4/2/16.
//  Copyright © 2016 Squad. All rights reserved.
//

import Cocoa
import FileKit

class VSBrowserViewController: NSViewController {

    @IBOutlet weak var browser: NSBrowser!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        preferredContentSize = NSSize(width: 500, height: 300)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        browser.action = #selector(self.didSelectSomething)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshSelectedColumn), name:"DataDidChange", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(displayNewSelectedPath), name:"SelectionChangedFromTreeMap", object: nil)
    }
    
    //get parent node for specific column
    func parentNodeForColumn(column: Int) -> Path {
        var result = VSExec.exec.rootPath
        for i in 0..<column {
            result = result.children(recursive: false)[browser.selectedRowInColumn(i)]
        }
        return result
    }
    
    func browser(sender: NSBrowser, numberOfRowsInColumn column: Int) -> Int {
        let parent = parentNodeForColumn(column)
        return parent.children(recursive: false).count
    }
    
    func browser(sender: NSBrowser, willDisplayCell cell: AnyObject, atRow row: Int, column: Int) {
        let theCell:NSBrowserCell = cell as! NSBrowserCell
        
        let path:Path = parentNodeForColumn(column)
        
        if row < path.children(recursive: false).count {
            theCell.title = path.children(recursive: false)[row].fileName
            theCell.leaf = !path.children(recursive: false)[row].isDirectory
        } else {
            theCell.title = ""
            theCell.leaf = false
        }
    }
    
    func didSelectSomething() {
        let row = browser.selectedRowInColumn(browser.selectedColumn)
        
        var parent:Path
        print(browser.selectedColumn)
        print(row)
        if browser.selectedColumn >= 0 {
            parent = parentNodeForColumn(browser.selectedColumn)
        } else {
            parent = parentNodeForColumn(0)
        }
        
        var path:Path
        if row >= 0 {
            path = parent.children(recursive: false)[row]
        } else {
            path = parent
        }
        VSExec.exec.selectedPath = path
        NSNotificationCenter.defaultCenter().postNotificationName("SelectedPathDidChange", object: nil)
    }
    
    func refreshSelectedColumn() {
        browser.reloadColumn(browser.selectedColumn)
    }
    
    func displayNewSelectedPath() {
//        print(VSExec.exec.selectedPath.rawValue)
//        print(browser.setPath(VSExec.exec.selectedPath.rawValue))
    }
}
