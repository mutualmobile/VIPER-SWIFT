//
//  UpcomingDisplayData.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

struct UpcomingDisplayData {
    let sections : [UpcomingDisplaySection]
}

extension UpcomingDisplayData : Equatable {
    static func == (leftSide: UpcomingDisplayData, rightSide: UpcomingDisplayData) -> Bool {
        return rightSide.sections == leftSide.sections
    }
}
