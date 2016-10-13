//
//  AddDataManager.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class AddDataManager : NSObject {
    var dataStore : CoreDataStore!
    
    func addNewEntry(_ entry: TodoItem) {
        let newEntry = dataStore.newTodoItem()
        newEntry.name = entry.name
        newEntry.date = entry.dueDate;
        
        dataStore.save()
    }
}
