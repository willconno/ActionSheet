//
//  ActionSheetPresenter.swift
//  ActionSheet
//
//  Created by William Connelly on 18/1/20.
//  Copyright © 2020 William Connelly. All rights reserved.
//

import UIKit

class ActionSheetPresenter: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    let BACKGROUND_VIEW_TAG = 111
    
    private var isPresenting = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromView = transitionContext.viewController(forKey: .from)!.view!
        let toView = transitionContext.viewController(forKey: .to)!.view!
        
        let workingView = isPresenting ? toView : fromView
        let presenterView = isPresenting ? fromView : toView
        
        let screenSize = CGSize(
            width: UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.height)
        
        
        if isPresenting {
            // Any presented views must be part of the container view's hierarchy
            
            let backgroundView = UIView(frame: CGRect(origin: .zero, size: screenSize))
            backgroundView.tag = BACKGROUND_VIEW_TAG
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
            backgroundView.alpha = 0
            
            presenterView.insertSubview(backgroundView, at: 0)
            transitionContext.containerView.addSubview(workingView)
            
            UIView.animate(withDuration: 0.3, animations: {
                backgroundView.alpha = 1
            }) { completed in
                if completed {
                    backgroundView.removeFromSuperview()
                }
            }
        } else {
            
            let backgroundView = UIView(frame: CGRect(origin: .zero, size: screenSize))
            backgroundView.tag = BACKGROUND_VIEW_TAG
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
            backgroundView.alpha = 1
            
            transitionContext.containerView.insertSubview(backgroundView, at: 0)
//            if let view = presenterView.subviews.first(where: {$0.tag == BACKGROUND_VIEW_TAG}) {
                
                UIView.animate(withDuration: 0.3, animations: {
                    backgroundView.alpha = 0
                }) { completed in
                    if completed {
//                        backgroundView.removeFromSuperview()
                    }
                }
                
//            }
        }
        
        let offScreenFrame = CGRect(origin: CGPoint(x: .zero, y: screenSize.height), size: screenSize)
        let onScreenFrame = CGRect(origin: .zero, size: screenSize)
        
        workingView.frame = isPresenting ? offScreenFrame : onScreenFrame
        
        UIView.animate(
            withDuration: duration,
            delay:0.0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            animations: {
                workingView.frame = self.isPresenting ? onScreenFrame : offScreenFrame
            }, completion: { (success) in
            
                if success {
                if !self.isPresenting {
                    workingView.removeFromSuperview()
                }
                
                transitionContext.completeTransition(success)
                }
            })
    }
    
    @objc func onBackgroundViewPressed(_ sender: UITapGestureRecognizer) {
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting isPresenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}
