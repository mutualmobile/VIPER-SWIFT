//
//  AddDismissalTransition.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit

class AddDismissalTransition : NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.72
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! AddViewController
        
        let finalCenter = CGPoint(x: 160.0, y: (fromVC.view.bounds.size.height / 2) - 1000.0)
        
        let options = UIViewAnimationOptions.curveEaseIn
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
            delay: 0.0,
            usingSpringWithDamping: 0.64,
            initialSpringVelocity: 0.22,
            options: options,
            animations: {
                fromVC.view.center = finalCenter
                fromVC.transitioningBackgroundView.alpha = 0.0
            },
            completion: { finished in
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        )
    }
    
}
