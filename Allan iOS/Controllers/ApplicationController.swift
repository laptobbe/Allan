//
//  ApplicationController.swift
//  Allan
//
//  Created by Tobias Sundstrand on 2015-02-28.
//  Copyright (c) 2015 Threadsafe Studio. All rights reserved.
//

class ApplicationController: NSObject, UISplitViewControllerDelegate {
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
        return false
    }
}