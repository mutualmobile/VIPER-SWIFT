
//
//  UpcomingDisplaySection.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

struct UpcomingDisplaySection {
    let name : String
    let imageName : String
    var items : [UpcomingDisplayItem] = []
}

extension UpcomingDisplaySection : Equatable {
    static func == (leftSide: UpcomingDisplaySection, rightSide: UpcomingDisplaySection) -> Bool {
        return rightSide.items == leftSide.items
    }
}
