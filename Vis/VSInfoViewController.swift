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
    @IBOutlet weak var titleTextView: NSTextField!
    
    // This is the place where we store text from a file for the text view
    
    var textStorage: NSTextStorage!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        preferredContentSize = NSSize(width: 500, height: 400)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageDisplay.wantsLayer = true
        
        // These string values correspond to the first column of labels 
        
        created.stringValue = "Created:"
        modified.stringValue = "Modified:"
        size.stringValue = "Size:"
        location.stringValue = "Where:"
        kind.stringValue = "Kind:"
        
        
        //  This is our observer for file selection. This is called whenever a new file is selected.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didReceiveNotification), name: "SelectedPathDidChange", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didReceiveNotification), name: "SelectionChangedFromTreeMap", object: nil)
        
    }
    
    // This function calls displayInformationForPath, which updates the entire view to the current path
    
    func didReceiveNotification() {
        displayInformationForPath(VSExec.exec.selectedPath)
    }
    
    // Function to update the view to the current path
    
    func displayInformationForPath ( fpath: Path)
    {
        // Date formatter turns an NSDate object ( IE 12/6/2016 ) into a string
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        
        // Number formatter adds commas to a number
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        // Hides the overlapping views
        fileInfo.editable = false
        fileInfo.hidden = true
        scrollView.hidden = true
        imageDisplay.hidden = true
        
        // Sets the values for file type
        titleTextView.stringValue = fpath.fileName
        locationInfo.stringValue = fpath.rawValue
        sizeInfo.stringValue = "\(numberFormatter.stringFromNumber(NSNumber(unsignedLongLong: fpath.fileSize!))!) Bytes"
        type.stringValue = fpath.pathExtension
        createdDate.stringValue = dateFormatter.stringFromDate(fpath.creationDate!)
        modifiedDate.stringValue = dateFormatter.stringFromDate(fpath.modificationDate!)
        
        if (fpath.isDirectory)
        {
            displayDirectory(fpath)
        }
            
        // Different functions for each type of file
            
        else
        {
            switch fpath.pathExtension {
                
            case "txt": displayTextFile(fpath)
                
            case "jpeg": displayImageFile(fpath)
                type.stringValue = "JPEG Image"
            case "jpg": displayImageFile(fpath)
                type.stringValue = "JPEG Image"
            case "png": displayImageFile(fpath)
                type.stringValue = "PNG Image"
            case "pdf": displayImageFile(fpath)
                type.stringValue = "Portable Document Format"
            case "tif": displayImageFile(fpath)
                type.stringValue = "TIFF Image"
            default:
                displayDefaultFile(fpath)
                
            }
        }
    }
    
    // function to display a text file
    
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
    
        fileInfo.textStorage?.setAttributedString(NSAttributedString(string: text))
        type.stringValue = "Plain Text Document"
        
        scrollView.hidden = false
        fileInfo.hidden = false
    }
    
    // function to display a directory
    
    func displayDirectory (fpath: Path)
    {
        type.stringValue = "Directory"
        let fImage: NSImage = NSImage(named: "Folder")!
        imageDisplay.layer?.backgroundColor = NSColor.clearColor().CGColor
        imageDisplay.hidden = false
        scrollView.hidden = true
        imageDisplay.image = fImage
        
    }
    
    //function to display the default file (a file type that hasn't been implemented yet)
    
    func displayDefaultFile (fpath: Path)
    {
        imageDisplay.hidden = true
        fileInfo.hidden = true
        scrollView.hidden = true
    }
    
    
    // function to display an image
    
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


