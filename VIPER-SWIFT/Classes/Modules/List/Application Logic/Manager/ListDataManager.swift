
//
//  ListDataManager.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class ListDataManager : NSObject {
    var coreDataStore : CoreDataStore?

    func todoItemsBetweenStartDate(startDate: NSDate, endDate: NSDate, completion: ((TodoItem[]) -> Void)!) {
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        let beginning = calendar.dateForBeginningOfDay(startDate)
        let end = calendar.dateForEndOfDay(endDate)
        
        let predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", beginning, end)
        let sortDescriptors = []
        
        coreDataStore?.fetchEntriesWithPredicate(predicate,
            sortDescriptors: sortDescriptors,
            completionBlock: { entries in
                let todoItems = self.todoItemsFromDataStoreEntries(entries)
                completion(todoItems)
        })
    }
    
    func todoItemsFromDataStoreEntries(entries: ManagedTodoItem[]) -> TodoItem[] {
        var todoItems : TodoItem[] = []
        
        for managedTodoItem in entries {
            let todoItem = TodoItem(dueDate: managedTodoItem.date, name: managedTodoItem.name)
            todoItems.append(todoItem)
        }
        
        return todoItems
    }
}