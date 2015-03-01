//
//  Task.swift
//  Allan
//
//  Created by Tobias Sundstrand on 2015-02-28.
//  Copyright (c) 2015 Threadsafe Studio. All rights reserved.
//

@objc(Task)
class Task: CBLModel {
    @NSManaged var title: NSString
    @NSManaged var note: NSString
}