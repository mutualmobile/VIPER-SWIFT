//
//  AddWireframe.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit

let AddViewControllerIdentifier = "AddViewController"

class AddWireframe : NSObject, UIViewControllerTransitioningDelegate {

    var addPresenter : AddPresenter?
    var presentedViewController : UIViewController?
    
    func presentAddInterfaceFromViewController(_ viewController: UIViewController) {
        let newViewController = addViewController()
        newViewController.eventHandler = addPresenter
        newViewController.modalPresentationStyle = .custom
        newViewController.transitioningDelegate = self
        
        addPresenter?.configureUserInterfaceForPresentation(newViewController)
        
        viewController.present(newViewController, animated: true, completion: nil)
        
        presentedViewController = newViewController
    }
    
    func dismissAddInterface() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func addViewController() -> AddViewController {
        let storyboard = mainStoryboard()
        let addViewController: AddViewController = storyboard.instantiateViewController(withIdentifier: AddViewControllerIdentifier) as! AddViewController
        return addViewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AddDismissalTransition()
    }
    
   func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AddPresentationTransition()
    }
}
