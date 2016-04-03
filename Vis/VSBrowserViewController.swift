//
//  VSBrowserViewController.swift
//  Vis
//
//  Created by Jim Boulter on 4/2/16.
//  Copyright © 2016 Squad. All rights reserved.
//

import Cocoa
import FileKit

class VSBrowserViewController: NSViewController, NSBrowserDelegate {

    @IBOutlet weak var browser: NSBrowser!
    var subpath :Path = Path.Current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        Path.Current = Path()
//        browser.action = #selector(self.didSelectSomething)
    }
    
    func browser(sender: NSBrowser, numberOfRowsInColumn column: Int) -> Int {
        if column == 1 {
            return subpath.children(recursive:false).count
        } else {
            return Path.Current.children(recursive:false).count
        }
    }
    
    func browser(sender: NSBrowser, willDisplayCell cell: AnyObject, atRow row: Int, column: Int) {
        var path: Path
        if column == 0 {
            path = Path.Current
        } else {
            path = subpath
        }
        let theCell:NSBrowserCell = cell as! NSBrowserCell
        if row < path.children().count {
            theCell.title = path.children()[row].fileName
            theCell.leaf = !path.children()[row].isDirectory
        }
        
        let _:String = String(path)
    }
    
    func didSelectSomething() {
        let row = browser.selectedRowInColumn(0)
        subpath = Path.Current.children()[row]
        browser.reloadColumn(1)
    }
    

}
