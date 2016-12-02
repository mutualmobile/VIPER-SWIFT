//
//  UpcomingDisplayDataCollection.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class UpcomingDisplayDataCollection {
    let dayFormatter = DateFormatter()
    var sections : [NearTermDateRelation: [UpcomingDisplayItem]] = [:]
    
    init() {
        dayFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEE", options: 0, locale: Locale.autoupdatingCurrent)
    }
    
    func addUpcomingItems(_ upcomingItems: [UpcomingItem]) {
        for upcomingItem in upcomingItems {
            addUpcomingItem(upcomingItem)
        }
    }
    
    func addUpcomingItem(_ upcomingItem: UpcomingItem) {
        let displayItem = displayItemForUpcomingItem(upcomingItem)
        addDisplayItem(displayItem, dateRelation: upcomingItem.dateRelation)
    }
    
    func addDisplayItem(_ displayItem: UpcomingDisplayItem, dateRelation: NearTermDateRelation) {
        if var realSection : [UpcomingDisplayItem] = sections[dateRelation] {
            realSection.append(displayItem)
            sections[dateRelation] = realSection
        } else {
            var newSection : [UpcomingDisplayItem] = []
            newSection.append(displayItem)
            sections[dateRelation] = newSection
        }
    }
    
    func displayItemForUpcomingItem(_ upcomingItem: UpcomingItem) -> UpcomingDisplayItem {
        let day = formattedDay(upcomingItem.dueDate as Date, dateRelation: upcomingItem.dateRelation)
        let displayItem = UpcomingDisplayItem(title: upcomingItem.title, dueDate: day)
        return displayItem
    }
    
    func formattedDay(_ date: Date, dateRelation: NearTermDateRelation) -> String {
        if dateRelation == NearTermDateRelation.today {
            return ""
        }
        
        return dayFormatter.string(from: date)
    }
    
    func collectedDisplayData() -> UpcomingDisplayData {
        let collectedSections : [UpcomingDisplaySection] = sortedUpcomingDisplaySections()
        return UpcomingDisplayData(sections: collectedSections)
    }
    
    func displaySectionForDateRelation(_ dateRelation: NearTermDateRelation) -> UpcomingDisplaySection {
        let sectionTitle = sectionTitleForDateRelation(dateRelation)
        let imageName = sectionImageNameForDateRelation(dateRelation)
        let items: [UpcomingDisplayItem] = sections[dateRelation]!
        
        return UpcomingDisplaySection(name: sectionTitle, imageName: imageName, items: items)
    }
    
    func sortedUpcomingDisplaySections() -> [UpcomingDisplaySection] {
        let keys = sortedNearTermDateRelations()
        var displaySections : [UpcomingDisplaySection] = []
        
        for dateRelation in keys {
            let itemArray = sections[dateRelation]
            
            if (itemArray != nil) {
                let displaySection = displaySectionForDateRelation(dateRelation)
                displaySections.insert(displaySection, at: displaySections.endIndex)
            }
        }
        
        return displaySections
    }
    
    func sortedNearTermDateRelations() -> [NearTermDateRelation] {
        var array : [NearTermDateRelation] = []
        array.insert(NearTermDateRelation.today, at: 0)
        array.insert(NearTermDateRelation.tomorrow, at: 1)
        array.insert(NearTermDateRelation.laterThisWeek, at: 2)
        array.insert(NearTermDateRelation.nextWeek, at: 3)
        return array
    }
    
    func sectionTitleForDateRelation(_ dateRelation: NearTermDateRelation) -> String {
        switch dateRelation {
        case .today:
            return "Today"
        case .tomorrow:
            return "Tomorrow"
        case .laterThisWeek:
            return "Later This Week"
        case .nextWeek:
            return "Next Week"
        case .outOfRange:
            return "Unknown"
        }
    }
    
    func sectionImageNameForDateRelation(_ dateRelation: NearTermDateRelation) -> String {
        switch dateRelation {
        case .today:
            return "check"
        case .tomorrow:
            return "alarm"
        case .laterThisWeek:
            return "circle"
        case .nextWeek:
            return "calendar"
        case .outOfRange:
            return "paper"
        }
    }
}
