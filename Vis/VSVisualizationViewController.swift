//
//  VSVisualizationViewController.swift
//  Vis
//
//  Created by Jim Boulter on 4/2/16.
//  Copyright © 2016 Squad. All rights reserved.
//

import Cocoa
import FileKit

class VSVisualizationViewController: NSViewController, TreeMapViewDataSource, TreeMapViewDelegate {

    @IBOutlet weak var treeMapView: TreeMapView!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        preferredContentSize = NSSize(width: 1000, height: 600)
    }
    
    let fileTypeColors: FileTypeColors = FileTypeColors()
    
    // load data from filesystem into visualization
    override func viewDidLoad() {
        super.viewDidLoad()
        treeMapView.reloadData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didReceiveNotification), name: "SelectedPathDidChange", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(selectionChangedNotification), name: TreeMapViewSelectionDidChangedNotification, object: nil)
    }
    
    // notification listener for change in selected path
    func didReceiveNotification() {
        let path = VSExec.exec.selectedPath.components.map{$0.rawValue} as [AnyObject]
        if VSExec.exec.selectedPath.isDirectory {
            treeMapView.reloadAndPerformZoomIntoItem(path)
        }
        else {
            
            if VSExec.exec.selectedPath != Path(String(treeMapView.rootItem())) {
                treeMapView.reloadAndPerformZoomOutofItem(path)
            } else {
                treeMapView.selectItemByPathToItem(path)
            }
        }
    }
    
    func selectionChangedNotification() {
        let item = String(treeMapView.selectedItem())
        print(item)
    }
    
    // TreeMapViewDataSource Implementation
    
    func asPath(item: AnyObject?) -> Path {
        if let i = item {
            return Path(String(i))
        } else {
            if !VSExec.exec.selectedPath.isDirectory {
                return VSExec.exec.selectedPath.parent
            }
            return VSExec.exec.selectedPath
        }
    }
    
    // returns child of directory at index
    func treeMapView(view: TreeMapView!, child index: UInt32, ofItem item: AnyObject?) -> AnyObject! {
        let path: Path = asPath(item)
        print(path)
        return path.children(recursive: false)[Int(index)].rawValue as AnyObject
    }
    
    // returns true if item is a directory, otherwise returns false
    func treeMapView(view: TreeMapView!, isNode item: AnyObject?) -> Bool {
        let path: Path = asPath(item)
        return path.isDirectory
    }
    
    // returns number of children in directory
    func treeMapView(view: TreeMapView!, numberOfChildrenOfItem item: AnyObject?) -> UInt32 {
        let path: Path = asPath(item)
        return UInt32(path.children().count)
    }
    
    // returns size of file at given path, 0 if path is a directory
    func treeMapView(view: TreeMapView!, weightByItem item: AnyObject?) -> UInt64 {
        let path: Path = asPath(item)
        if path.isDirectory {
            print(path.fileSize)
            return 0
        }
        return path.fileSize!
    }
    
    // TreeMapViewDelegate Implementation
    
    // return tooltip value for file
    func treeMapView(view: TreeMapView!, getToolTipByItem item: AnyObject?) -> String! {
        return asPath(item).description
    }
    
    /*  
        sets color based on file type.
        has loose dependency on FileTypeColors, this could easily be swapped out for any other system:
        the function of FileTypeColors is simply to return an NSColor given a file type as a string.
     */
    func treeMapView(view: TreeMapView!, willDisplayItem item: AnyObject?, withRenderer renderer: TMVItem!) {
        let path: Path = asPath(item)
        let color: NSColor = fileTypeColors.colorForKind(path.pathExtension)
        renderer.setCushionColor(color)
    }
    
    func treeMapView(view: TreeMapView!, needsDeleteItem item: AnyObject!) {
        if let _ = item {
            if let itemPath:Path! = Path(String(item!)) {
                do {
                    try itemPath.deleteFile()
                    let path = VSExec.exec.selectedPath.components.map{$0.rawValue} as [AnyObject]
                    treeMapView.reloadAndPerformZoomIntoItem(path)
                    NSNotificationCenter.defaultCenter().postNotificationName("DataDidChange", object: self)
                } catch FileKitError.DeleteFileFail {
                    //File deletion failed
                } catch {
                    //Who knows?
                }
            }
        }
        
    }
    
    // NOT IMPLEMENTED YET
    
    func treeMapView(view: TreeMapView!, willShowMenuForEvent event: NSEvent!) {
        
    }
    
    func treeMapView(view: TreeMapView!, shouldSelectItem item: AnyObject?) -> Bool {
        return true;
    }
//    
//    @interface NSObject(TreeMapViewNotifications)
//    - (void)treeMapViewSelectionDidChange: (NSNotification*) notification;
//    - (void)treeMapViewSelectionIsChanging: (NSNotification*) notification; //not yet implemented
//    - (void)treeMapViewItemTouched: (NSNotification*) notification;
//    @end
//
    override func treeMapViewSelectionDidChange(notification: NSNotification!) {

    }
}
