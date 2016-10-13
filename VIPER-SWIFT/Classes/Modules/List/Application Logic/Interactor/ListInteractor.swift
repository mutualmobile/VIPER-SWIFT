//
//  ListInteractor.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class ListInteractor : NSObject, ListInteractorInput {
    var output : ListInteractorOutput?
    
    let clock : Clock
    let dataManager : ListDataManager
    
    init(dataManager: ListDataManager, clock: Clock) {
        self.dataManager = dataManager
        self.clock = clock
    }
    
    func findUpcomingItems() {
        let today = clock.today()
        let endOfNextWeek = Calendar.current.dateForEndOfFollowingWeekWithDate(today)
        
        dataManager.todoItemsBetweenStartDate(today,
            endDate: endOfNextWeek,
            completion: { todoItems in
                let upcomingItems = self.upcomingItemsFromToDoItems(todoItems)
                self.output?.foundUpcomingItems(upcomingItems)
        })
    }
    
    func upcomingItemsFromToDoItems(_ todoItems: [TodoItem]) -> [UpcomingItem] {
        let calendar = Calendar.autoupdatingCurrent
        
        let upcomingItems: [UpcomingItem] = todoItems.map() { todoItem in
            let dateRelation = calendar.nearTermRelationForDate(todoItem.dueDate, relativeToToday: clock.today())
            return UpcomingItem(title: todoItem.name, dueDate: todoItem.dueDate, dateRelation: dateRelation)
        }
        return upcomingItems
    }
}
