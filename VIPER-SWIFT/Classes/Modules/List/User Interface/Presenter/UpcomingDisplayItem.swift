//
//  UpcomingDisplayItem.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

struct UpcomingDisplayItem : Equatable {
    let title : String
    let dueDate : String
}

func == (leftSide: UpcomingDisplayItem, rightSide: UpcomingDisplayItem) -> Bool {
    if rightSide.title != leftSide.title {
        return false
    }
    
    return rightSide.dueDate == rightSide.dueDate
}

extension UpcomingDisplayItem: CustomStringConvertible {

    var description : String {
        return "\(title) -- \(dueDate)"
    }

}
