//
//  AddModuleInterface.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

protocol AddModuleInterface {
    func cancelAddAction()
    func saveAddActionWithName(name: String, dueDate: NSDate)
}