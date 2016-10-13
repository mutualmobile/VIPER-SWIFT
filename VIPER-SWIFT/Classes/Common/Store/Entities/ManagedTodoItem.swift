//
//  ManagedTodoItem.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Conrad Stoll. All rights reserved.
//

import Foundation
import CoreData

class ManagedTodoItem : NSManagedObject {
    @NSManaged var name : String
    @NSManaged var date : Date
}
