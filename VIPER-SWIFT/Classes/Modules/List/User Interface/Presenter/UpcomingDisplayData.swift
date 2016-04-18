//
//  UpcomingDisplayData.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

struct UpcomingDisplayData : Equatable {
    let sections : [UpcomingDisplaySection]
}

func == (leftSide: UpcomingDisplayData, rightSide: UpcomingDisplayData) -> Bool {
    var hasEqualSections = false
    hasEqualSections = rightSide.sections == leftSide.sections
    return hasEqualSections
}