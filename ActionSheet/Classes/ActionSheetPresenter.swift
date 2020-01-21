//
//  ActionSheetPresenter.swift
//  ActionSheet
//
//  Created by William Connelly on 18/1/20.
//  Copyright © 2020 William Connelly. All rights reserved.
//

import UIKit

class ActionSheetPresenter: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    let BACKGROUND_VIEW_TAG = 999
    
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
            transitionContext.containerView.addSubview(backgroundView)

            transitionContext.containerView.addSubview(workingView)
            
            UIView.animate(withDuration: 0.3) {
                backgroundView.alpha = 1
            }
            
        } else {
            
            if let view = transitionContext.containerView.subviews.first(where: {$0.tag == BACKGROUND_VIEW_TAG}) {
                
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = 0
                }) { completed in
                    if completed {
                        view.removeFromSuperview()
                    }
                }
                
            }
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
            
                if !self.isPresenting {
                    workingView.removeFromSuperview()
                }
                
                transitionContext.completeTransition(success)
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
