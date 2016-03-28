
//
//  UpcomingDisplaySection.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

struct UpcomingDisplaySection : Equatable {
    let name : String
    let imageName : String
    var items : [UpcomingDisplayItem] = []
}

func == (leftSide: UpcomingDisplaySection, rightSide: UpcomingDisplaySection) -> Bool {
    var hasEqualSections = false
    hasEqualSections = rightSide.items == leftSide.items
    return hasEqualSections
}