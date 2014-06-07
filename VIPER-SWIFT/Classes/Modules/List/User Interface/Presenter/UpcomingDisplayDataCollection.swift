//
//  UpcomingDisplayDataCollection.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class UpcomingDisplayDataCollection {
    let dayFormatter = NSDateFormatter()
    var sections : Dictionary<NearTermDateRelation, UpcomingDisplayItem[]> = Dictionary()
    
    init() {
        dayFormatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("EEEE", options: 0, locale: NSLocale.autoupdatingCurrentLocale())
    }
    
    func addUpcomingItems(upcomingItems: UpcomingItem[]) {
        for upcomingItem in upcomingItems {
            addUpcomingItem(upcomingItem)
        }
    }
    
    func addUpcomingItem(upcomingItem: UpcomingItem) {
        var displayItem = displayItemForUpcomingItem(upcomingItem)
        addDisplayItem(displayItem, dateRelation: upcomingItem.dateRelation)
    }
    
    func addDisplayItem(displayItem: UpcomingDisplayItem, dateRelation: NearTermDateRelation) {
        if var realSection : UpcomingDisplayItem[] = sections[dateRelation] {
            realSection.append(displayItem)
            sections[dateRelation] = realSection
        } else {
            var newSection : UpcomingDisplayItem[] = []
            newSection.append(displayItem)
            sections[dateRelation] = newSection
        }
    }
    
    func displayItemForUpcomingItem(upcomingItem: UpcomingItem) -> UpcomingDisplayItem {
        let day = formattedDay(upcomingItem.dueDate, dateRelation: upcomingItem.dateRelation)
        let displayItem = UpcomingDisplayItem(title: upcomingItem.title, dueDate: day)
        return displayItem
    }
    
    func formattedDay(date: NSDate, dateRelation: NearTermDateRelation) -> String {
        if dateRelation == NearTermDateRelation.Today {
            return ""
        }
        
        return dayFormatter.stringFromDate(date)
    }
    
    func collectedDisplayData() -> UpcomingDisplayData {
        let collectedSections : UpcomingDisplaySection[] = sortedUpcomingDisplaySections()
        return UpcomingDisplayData(sections: collectedSections)
    }
    
    func displaySectionForDateRelation(dateRelation: NearTermDateRelation) -> UpcomingDisplaySection {
        let sectionTitle = sectionTitleForDateRelation(dateRelation)
        let imageName = sectionImageNameForDateRelation(dateRelation)
        let items = sections[dateRelation]
        
        return UpcomingDisplaySection(name: sectionTitle, imageName: imageName, items: items)
    }
    
    func sortedUpcomingDisplaySections() -> UpcomingDisplaySection[] {
        let keys = sortedNearTermDateRelations()
        var displaySections : UpcomingDisplaySection[] = []
        
        for dateRelation in keys {
            var itemArray = sections[dateRelation]
            
            if itemArray {
                var displaySection = displaySectionForDateRelation(dateRelation)
                displaySections.insert(displaySection, atIndex: displaySections.endIndex)
            }
        }
        
        return displaySections
    }
    
    func sortedNearTermDateRelations() -> NearTermDateRelation[] {
        var array : NearTermDateRelation[] = []
        array.insert(NearTermDateRelation.Today, atIndex: 0)
        array.insert(NearTermDateRelation.Tomorrow, atIndex: 1)
        array.insert(NearTermDateRelation.LaterThisWeek, atIndex: 2)
        array.insert(NearTermDateRelation.NextWeek, atIndex: 3)
        return array
    }
    
    func sectionTitleForDateRelation(dateRelation: NearTermDateRelation) -> String {
        switch dateRelation {
        case .Today:
            return "Today"
        case .Tomorrow:
            return "Tomorrow"
        case .LaterThisWeek:
            return "Later This Week"
        case .NextWeek:
            return "Next Week"
        case .OutOfRange:
            return "Unknown"
        }
    }
    
    func sectionImageNameForDateRelation(dateRelation: NearTermDateRelation) -> String {
        switch dateRelation {
        case .Today:
            return "check"
        case .Tomorrow:
            return "alarm"
        case .LaterThisWeek:
            return "circle"
        case .NextWeek:
            return "calendar"
        case .OutOfRange:
            return "paper"
        }
    }
}