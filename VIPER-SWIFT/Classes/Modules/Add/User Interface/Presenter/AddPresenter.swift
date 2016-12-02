//
//  AddPresenter.swift
//  VIPER TODO
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class AddPresenter : NSObject, AddModuleInterface {
    var addInteractor : AddInteractor?
    var addWireframe : AddWireframe?
    var addModuleDelegate : AddModuleDelegate?
    
    func cancelAddAction() {
        addWireframe?.dismissAddInterface()
        addModuleDelegate?.addModuleDidCancelAddAction()
    }
    
    func saveAddActionWithName(_ name: String, dueDate: Date) {
        addInteractor?.saveNewEntryWithName(name, dueDate: dueDate);
        addWireframe?.dismissAddInterface()
        addModuleDelegate?.addModuleDidSaveAddAction()
    }
    
    func configureUserInterfaceForPresentation(_ addViewUserInterface: AddViewInterface) {
        addViewUserInterface.setMinimumDueDate(Date())
    }
}
