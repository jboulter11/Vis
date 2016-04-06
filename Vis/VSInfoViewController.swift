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
    
    let fileName: Path = "/Users/Grippj/Documents/Departure.jpg"
    
    // It's hard to see these view on the storyboard but the textview is inside of the 
    // scrollview. The image view is stacked ontop of the scrollview.

    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet var fileInfo: NSTextView!
    @IBOutlet weak var imageDisplay: NSImageView!
    
    // These are all the ten labels on the storyboard for
    // VSInfoViewController.
    
    @IBOutlet weak var sizeInfo: NSTextField!
    @IBOutlet weak var size: NSTextField!
    @IBOutlet weak var type: NSTextField!
    @IBOutlet weak var kind: NSTextField!
    @IBOutlet weak var created: NSTextField!
    @IBOutlet weak var createdDate: NSTextField!
    @IBOutlet weak var modified: NSTextField!
    @IBOutlet weak var modifiedDate: NSTextField!
    @IBOutlet weak var location: NSTextField!
    @IBOutlet weak var locationInfo: NSTextField!
    
    var textStorage: NSTextStorage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // These string values correspond to the first column of labels 
        
        created.stringValue = "Created:"
        modified.stringValue = "Modified:"
        size.stringValue = "Size:"
        location.stringValue = "Where:"
        kind.stringValue = "Kind:"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didReceiveNotification), name: "SelectedPathDidChange", object: nil)
        
        //printFilePath(fileName)
//        displayInformationForPath(fileName)
        
    }
    
    func didReceiveNotification() {
        print(VSExec.exec.selectedPath)
        displayInformationForPath(VSExec.exec.selectedPath)
    }
    
    func displayInformationForPath ( fpath: Path)
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        //numberFormatter.stringFromNumber(NSNumber(unsignedLongLong: fpath.fileSize!))!
        
        fileInfo.editable = false
        scrollView.hidden = true
        imageDisplay.hidden = true
        
        locationInfo.stringValue = fpath.rawValue
        sizeInfo.stringValue = "\(numberFormatter.stringFromNumber(NSNumber(unsignedLongLong: fpath.fileSize!))!) Bytes"
        type.stringValue = fpath.pathExtension
        createdDate.stringValue = dateFormatter.stringFromDate(fpath.creationDate!)
        modifiedDate.stringValue = dateFormatter.stringFromDate(fpath.modificationDate!)
        
        if (fpath.isDirectory)
        {
            type.stringValue = "Directory"
        }
        
        switch fpath.pathExtension {
            
        case "txt": displayTextFile(fpath)
        case "jpg": displayImageFile(fpath)
            type.stringValue = "JPEG Image"
        case "png": displayImageFile(fpath)
            type.stringValue = "PNG Image"
        case "tif": displayImageFile(fpath)
            type.stringValue = "TIFF Image"
        default:
            print("error")
            
        }
        
    }
    
    func displayTextFile (fpath: Path)
    {
        textStorage = NSTextStorage()
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(containerSize: view.frame.size)
        layoutManager.addTextContainer(textContainer)
        var text: String = ""
        
        do {
            text = try String(contentsOfFile: fpath.rawValue, encoding: NSUTF8StringEncoding)
        }
        catch {/* error handling here */}
        
        fileInfo.textStorage?.appendAttributedString(NSAttributedString(string: text))
        type.stringValue = "Plain Text Document"
        
        scrollView.hidden = false
    }
    
    func displayImageFile (fpath: Path)
    {
        imageDisplay.hidden = false
        do{
            let image = NSImage(contentsOfFile: fpath.rawValue)
            imageDisplay.image = image
        }
    }
    
    // TODO: Write test for this class, testing correct info displayed for file
}


