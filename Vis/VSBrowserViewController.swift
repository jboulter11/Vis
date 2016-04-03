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
    }
    
    func browser(sender: NSBrowser, numberOfRowsInColumn column: Int) -> Int {
        if column == 0 {
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
        
        cell.setTitle(path.children()[row].fileName)
//        cell.leaf(!path.children()[row].isDirectory)
    }
    
}
