//
//  ActionSheetController.swift
//  ActionSheet
//
//  Created by William Connelly on 28/1/20.
//

import Foundation
import UIKit

public class ActionSheetController: UIViewController {
    @IBOutlet var backgroundView: UIView!
    
    /// insert new items at index 0 to mainContainer
    @IBOutlet var containerView: UIStackView!
    @IBOutlet var mainContainer: UIStackView?
    
    @IBOutlet var primaryButtonContainer: UIStackView?
    @IBOutlet var actionButtonContainer: UIStackView?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        
        // Prevent any jerking animations
        self.containerView.isHidden = true
        self.backgroundView.isHidden = true
        
        if titleText != nil || subtitleText != nil {
            let titleView = ActionSheetTitleView(title: titleText, message: subtitleText)
            actionButtonContainer?.addArrangedSubview(titleView)
        }
        
        for button in primaryButtons {
            if button != actionButtons.last {
                button.seperatorView?.isHidden = false
            }
            primaryButtonContainer?.addArrangedSubview(button)
        }
        
        for button in actionButtons {
            button.blur(style: .extraLight)
            button.backgroundView?.backgroundColor = UIColor.clear
            if button != actionButtons.last {
                button.seperatorView?.isHidden = false
            }
            actionButtonContainer?.addArrangedSubview(button)
        }
        
        for button in heroButtons {
            if button != actionButtons.last {
                button.seperatorView?.isHidden = false
            }
            mainContainer?.insertArrangedSubview(button, at: 0)
        }
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate(isPresenting: true)
    }
    
    func animate(isPresenting: Bool, _ completionHandler: @escaping (() -> Void) = {}) {
        
        let screenSize = CGSize(
            width: UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.height)
        
        //Move all views off screen
        if isPresenting {
            self.containerView.frame = CGRect(origin: CGPoint(x: .zero, y: self.containerView.frame.size.height), size: self.containerView.frame.size)
            self.backgroundView.alpha = 0
            
            // Hidden in viewDidLoad to avoid any jerking
            self.containerView.isHidden = false
            self.backgroundView.isHidden = false
        }
        
        UIView.animate(
            withDuration: 0.4,
            delay:0.0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            animations: {
                self.containerView.frame = isPresenting ? CGRect(origin: .zero, size: screenSize) : CGRect(origin: CGPoint(x: self.containerView.frame.origin.x, y: screenSize.height), size: self.containerView.frame.size)
                self.backgroundView.alpha = isPresenting ? 0.2 : 0
        }, completion: { (success) in
            
            if success {
                if !isPresenting {
                    
                    // Hide to avoid any jerking
                    self.containerView.isHidden = true
                    self.backgroundView.isHidden = true
                    
                    self.dismiss(animated: false)
                    completionHandler()
                }
                
            }
        })
    }
    
    private var titleText: String?
    private var subtitleText: String?
    private var actionButtons = [ActionButton]()
    private var primaryButtons = [ActionButton]()
    private var heroButtons = [ActionButton]()
    
    public func dismiss(_ completionHandler: @escaping () -> Void) {
        animate(isPresenting: false, completionHandler)
    }
    
    @objc func animateOut(_ sender: Any? = nil) {
        builder?.dismiss()
    }
    
    private var builder: ActionSheet?
    
    static func createInstance(builder: ActionSheet) -> ActionSheetController? {
        guard let result = UIStoryboard(name: "ActionSheet", bundle: Bundle(identifier: "org.cocoapods.ActionSheet")).instantiateViewController(withIdentifier: "ActionSheetController") as? ActionSheetController else {
            return nil
        }
        
        result.builder = builder
        result.titleText = builder.title
        result.subtitleText = builder.message
        result.primaryButtons = builder.primaryButtons
        result.actionButtons = builder.actionButtons
        result.heroButtons = builder.heroButtons
        
        return result
    }
    
    deinit {
        print("DEINIT - \(self.debugDescription)")
    }
}
