//
//  VSInfoViewController.swift
//  Vis
//
//  Created by james grippo on 4/2/16.
//  Copyright © 2016 Squad. All rights reserved.
//

import Cocoa
import FileKit

class VSInfoViewController: NSViewController {
    
    let fileName: Path = "/Users/Grippj/Documents/"
    
    @IBOutlet weak var path: NSTextField!
    @IBOutlet weak var size: NSTextField!
    @IBOutlet weak var type: NSTextField!
    @IBOutlet weak var created: NSTextField!
    @IBOutlet weak var createdDate: NSTextField!
    @IBOutlet weak var modified: NSTextField!
    @IBOutlet weak var modifiedDate: NSTextField!
    @IBOutlet weak var lastOpened: NSTextField!
    @IBOutlet weak var lastOpenedDate: NSTextField!
    @IBOutlet weak var dimension: NSTextField!
    @IBOutlet weak var dimensionNumbers: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        created.stringValue = "Created:"
        modified.stringValue = "Modified:"
        lastOpened.stringValue = "Last Opened:"
        dimension.stringValue = "Dimensions:"
        
        printFilePath(fileName)
        displayInformationForPath(fileName)
        
    }
    
    func displayInformationForPath ( fpath: Path)
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        
        path.stringValue = fpath.rawValue
        size.stringValue = String(fpath.fileSize)
        type.stringValue = fpath.pathExtension
        createdDate.stringValue = dateFormatter.stringFromDate(fpath.creationDate!)
        modifiedDate.stringValue = dateFormatter.stringFromDate(fpath.modificationDate!)

        
    }
    func printFilePath (fpath: Path)
    {
        print(fpath.attributes)
    }
    
    // TODO: Write test for this class, testing correct info displayed for file
}


