//
//  GroceryItemAnimator.swift
//  groceryListTest
//
//  Created by Oren Cohen on 02/04/2018.
//  Copyright © 2018 anydo. All rights reserved.
//

import UIKit

class GroceryItemAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        let itemFullscreenView = presenting ? toView :
            transitionContext.view(forKey: .from)!
        
        let initialFrame = presenting ? originFrame : itemFullscreenView.frame
        let finalFrame = presenting ? itemFullscreenView.frame : originFrame
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            itemFullscreenView.transform = scaleTransform
            itemFullscreenView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            itemFullscreenView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: itemFullscreenView)
        
        UIView.animate(withDuration: duration, delay:0.0,
                       usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0,
                       animations: {
                        if self.presenting {
                            itemFullscreenView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                            itemFullscreenView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
                        } else {
                            itemFullscreenView.alpha = 0
                        }
                        
        },
                       completion: { _ in
                        transitionContext.completeTransition(true)
        }
        )
        
    }
    
}
