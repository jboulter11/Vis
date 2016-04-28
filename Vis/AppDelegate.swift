//
//  AppDelegate.swift
//  Vis
//
//  Created by Jim Boulter on 4/2/16.
//  Copyright © 2016 Squad. All rights reserved.
//

import Cocoa
import FileKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
//        Path.Current = Path("/Users/grippj/Documents/Vis")
        #if TESTING
            do{
                let dPath = Path.UserDocuments + "Test Directory/Text Files/deleteme.txt"
                try dPath.touch(true)
            }catch{
                    print("\n\n\n ur on crack \n\n\n\n")
            }
        #endif
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

