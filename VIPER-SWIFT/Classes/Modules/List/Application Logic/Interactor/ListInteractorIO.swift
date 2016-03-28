//
//  ListInteractorIO.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation


protocol ListInteractorInput {
    func findUpcomingItems()
}

protocol ListInteractorOutput {
    func foundUpcomingItems(upcomingItems: [UpcomingItem])
}
