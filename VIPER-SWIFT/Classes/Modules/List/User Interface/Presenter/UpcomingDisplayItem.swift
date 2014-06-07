//
//  UpcomingDisplayItem.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

struct UpcomingDisplayItem : Equatable, Printable {
    let title : String = ""
    let dueDate : String = ""
    
    var description : String { get {
        return "\(title) -- \(dueDate)"
    }}
    
    init(title: String, dueDate: String) {
        self.title = title
        self.dueDate = dueDate
    }
}

func == (leftSide: UpcomingDisplayItem, rightSide: UpcomingDisplayItem) -> Bool {
    var hasEqualSections = false
    hasEqualSections = rightSide.title == leftSide.title
    
    if hasEqualSections == false {
        return false
    }
    
    hasEqualSections = rightSide.dueDate == rightSide.dueDate
    
    return hasEqualSections
}