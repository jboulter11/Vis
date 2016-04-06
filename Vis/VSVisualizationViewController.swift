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
    
    let fileTypeColors: FileTypeColors = FileTypeColors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
//        treeMapView.delegate
        treeMapView.reloadData()
        
    }
    
    
    // TreeMapViewDataSource Implementation
    
    func asPath(item: AnyObject?) -> Path {
        if let i = item {
            return Path(String(i))
        } else {
            return Path("/Users/richie/Dev/rcos-yacs/yacs")
        }
    }
    
    func treeMapView(view: TreeMapView!, child index: UInt32, ofItem item: AnyObject?) -> AnyObject! {
        let path: Path = asPath(item)
        print(path)
        return path.children(recursive: false)[Int(index)].rawValue as AnyObject
    }
    
    func treeMapView(view: TreeMapView!, isNode item: AnyObject?) -> Bool {
//        let path = toPath(item)
        return true
    }
    
    func treeMapView(view: TreeMapView!, numberOfChildrenOfItem item: AnyObject?) -> UInt32 {
        let path: Path = asPath(item)
        let children = path.children()
        return UInt32(path.children().count)
    }
    
    func treeMapView(view: TreeMapView!, weightByItem item: AnyObject?) -> UInt64 {
        return asPath(item).fileSize!
    }
    
    // TreeMapViewDelegate Implementation
    
    func treeMapView(view: TreeMapView!, getToolTipByItem item: AnyObject?) -> String! {
        return asPath(item).description
    }
    
    func treeMapView(view: TreeMapView!, willDisplayItem item: AnyObject?, withRenderer renderer: TMVItem!) {
        let path = asPath(item)
        renderer.setCushionColor(fileTypeColors.colorForKind(path.fileType?.rawValue))
    }
    
    func treeMapView(view: TreeMapView!, willShowMenuForEvent event: NSEvent!) {
        
    }
    
    func treeMapView(view: TreeMapView!, shouldSelectItem item: AnyObject?) -> Bool {
        return false;
    }
}
