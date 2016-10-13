//
//  UpcomingItem.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

struct UpcomingItem : Equatable {
    let title : String
    let dueDate : Date
    let dateRelation : NearTermDateRelation
    
    init(title: String, dueDate: Date = Date(), dateRelation: NearTermDateRelation = NearTermDateRelation.outOfRange) {
        self.title = title
        self.dueDate = dueDate
        self.dateRelation = dateRelation
    }
}

func == (leftSide: UpcomingItem, rightSide: UpcomingItem) -> Bool {
    var hasEqualSections = false
    hasEqualSections = rightSide.title == leftSide.title
    
    if hasEqualSections == false {
        return false
    }
    
    hasEqualSections = rightSide.dueDate == rightSide.dueDate
    
    if hasEqualSections == false {
        return false
    }
    
    hasEqualSections = rightSide.dateRelation == rightSide.dateRelation
    
    return hasEqualSections
}
