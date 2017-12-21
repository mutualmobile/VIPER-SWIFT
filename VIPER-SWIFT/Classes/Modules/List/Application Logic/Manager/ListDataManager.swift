
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

    func todoItemsBetweenStartDate(_ startDate: Date, endDate: Date, completion: (([TodoItem]) -> Void)!) {
        let calendar = Calendar.autoupdatingCurrent
        let beginning = calendar.dateForBeginningOfDay(startDate)
        let end = calendar.dateForEndOfDay(endDate)
        
        let predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", beginning as CVarArg, end as CVarArg)
        let sortDescriptors: [NSSortDescriptor] = []
        
        coreDataStore?.fetchEntriesWithPredicate(predicate,
            sortDescriptors: sortDescriptors,
            completionBlock: { entries in
                let todoItems = self.todoItemsFromDataStoreEntries(entries)
                completion(todoItems)
        })
    }
    
    func todoItemsFromDataStoreEntries(_ entries: [ManagedTodoItem]) -> [TodoItem] {
        let todoItems : [TodoItem] = entries.map { entry in
            TodoItem(dueDate: entry.date, name: entry.name as String)
        }
        
        return todoItems
    }
}
