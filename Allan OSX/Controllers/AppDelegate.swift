//
//  AppDelegate.swift
//  Allan OSX
//
//  Created by Tobias Sundstrand on 2015-03-01.
//  Copyright (c) 2015 Threadsafe Studio. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var peerConnect: PeerConnect?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let credentials = "odouid:eudoeud".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        self.peerConnect = PeerConnect(credentials: credentials, accept: { (completion) -> Void in
            let alert:NSAlert = NSAlert()
            alert.addButtonWithTitle("Accept")
            alert.addButtonWithTitle("Deny")
            alert.messageText = "Link devices"
            alert.informativeText = "Linking devices will keep these devices in sync"
            alert.alertStyle = .InformationalAlertStyle
            alert.beginSheetModalForWindow(NSApplication.sharedApplication().mainWindow!, completionHandler: { (response) -> Void in
                completion(response == NSAlertFirstButtonReturn)
            })
        }, found: { (data) -> Void in
            
        })
        self.peerConnect?.broadcastSync()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}


