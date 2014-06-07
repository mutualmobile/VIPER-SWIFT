//
//  AppDependencies.swift
//  VIPER TODO
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    var listWireframe = ListWireframe()
    
    init() {
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        listWireframe.presentListInterfaceFromWindow(window)
    }
    
    func configureDependencies() {
        let coreDataStore = CoreDataStore()
        let clock = DeviceClock()
        let rootWireframe = RootWireframe()
        
        let listPresenter = ListPresenter()
        let listDataManager = ListDataManager()
        let listInteractor = ListInteractor(dataManager: listDataManager, clock: clock)
        
        let addWireframe = AddWireframe()
        let addInteractor = AddInteractor()
        let addPresenter = AddPresenter()
        let addDataManager = AddDataManager()
        
        listInteractor.output = listPresenter
        
        listPresenter.listInteractor = listInteractor
        listPresenter.listWireframe = listWireframe
        
        listWireframe.addWireframe = addWireframe
        listWireframe.listPresenter = listPresenter
        listWireframe.rootWireframe = rootWireframe
        
        listDataManager.coreDataStore = coreDataStore
        
        addInteractor.addDataManager = addDataManager
        
        addWireframe.addPresenter = addPresenter
        
        addPresenter.addWireframe = addWireframe
        addPresenter.addModuleDelegate = listPresenter
        addPresenter.addInteractor = addInteractor
        
        addDataManager.dataStore = coreDataStore
    }
}