//
//  VSExec.swift
//  Vis
//
//  Created by Jim Boulter on 4/6/16.
//  Copyright © 2016 Squad. All rights reserved.
//

import Cocoa
import FileKit

class VSExec {
    var selectedPath:Path = Path.UserDocuments
    let rootPath:Path = Path.UserDocuments
    var rightClickedFile:Path!
    
    static var exec = VSExec()
}
