//
//  ListPresenter.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit

class ListPresenter : NSObject, ListInteractorOutput, ListModuleInterface, AddModuleDelegate {
    var listInteractor : ListInteractorInput?
    var listWireframe : ListWireframe?
    var userInterface : ListViewInterface?
    
    func updateView() {
        listInteractor?.findUpcomingItems()
    }
    
    func foundUpcomingItems(upcomingItems: [UpcomingItem]) {
        if upcomingItems.count == 0 {
            userInterface?.showNoContentMessage()
        } else {
            updateUserInterfaceWithUpcomingItems(upcomingItems)
        }
    }
    
    func updateUserInterfaceWithUpcomingItems(upcomingItems: [UpcomingItem]) {
        let upcomingDisplayData = upcomingDisplayDataWithItems(upcomingItems)
        userInterface?.showUpcomingDisplayData(upcomingDisplayData)
    }
    
    func upcomingDisplayDataWithItems(upcomingItems: [UpcomingItem]) -> UpcomingDisplayData {
        let collection = UpcomingDisplayDataCollection()
        collection.addUpcomingItems(upcomingItems)
        return collection.collectedDisplayData()
    }
    
    func addNewEntry() {
        listWireframe?.presentAddInterface()
    }
    
    func addModuleDidCancelAddAction() {
        // No action necessary
    }
    
    func addModuleDidSaveAddAction() {
        updateView()
    }
}