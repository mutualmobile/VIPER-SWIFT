//
//  AddViewInterface.swift
//  VIPER TODO
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

protocol AddViewInterface {
    func setEntryName(_ name: String)
    func setEntryDueDate(_ date: Date)
    func setMinimumDueDate(_ date: Date)
}
