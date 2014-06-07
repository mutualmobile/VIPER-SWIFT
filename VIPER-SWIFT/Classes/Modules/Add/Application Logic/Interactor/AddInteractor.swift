//
//  AddInteractor.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class AddInteractor : NSObject {
    var addDataManager : AddDataManager?
    
    func saveNewEntryWithName(name: NSString, dueDate: NSDate) {
        let newEntry = TodoItem(dueDate: dueDate, name: name)
        addDataManager?.addNewEntry(newEntry)
    }
}