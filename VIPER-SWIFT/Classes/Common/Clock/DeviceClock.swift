//
//  DeviceClock.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class DeviceClock : NSObject, Clock {
    func today() -> Date {
        return Date()
    }
}
