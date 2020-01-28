//
//  ActionSheet.swift
//  ActionSheet
//
//  Created by William Connelly on 16/9/19.
//  Copyright © 2019 William Connelly. All rights reserved.
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
    
    func animate(isPresenting: Bool) {
        
        let screenSize = CGSize(
            width: UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.height)
        
        let offScreenFrame = CGRect(origin: CGPoint(x: .zero, y: screenSize.height), size: screenSize)
        //Move all views off screen
        if isPresenting {
            self.containerView.frame = CGRect(origin: CGPoint(x: .zero, y: self.containerView.frame.size.height), size: self.containerView.frame.size)
            self.backgroundView.alpha = 0
        }
        
        
        UIView.animate(
            withDuration: 0.4,
            delay:0.0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            animations: {
                self.containerView.frame = isPresenting ? CGRect(origin: .zero, size: screenSize) : CGRect(origin: CGPoint(x: self.containerView.frame.origin.x, y: screenSize.height), size: self.containerView.frame.size)
                self.backgroundView.alpha = isPresenting ? 0.15 : 0
        }, completion: { (success) in
            
            if success {
                if !isPresenting {
                    self.dismiss(animated: false)
                }
                
            }
        })
    }
    
    private var titleText: String?
    private var subtitleText: String?
    private var actionButtons = [ActionButton]()
    private var primaryButtons = [ActionButton]()
    private var heroButtons = [ActionButton]()
    
    public func dismiss() {
        animateOut()
    }
    
    @objc func animateOut(_ sender: Any? = nil) {
        animate(isPresenting: false)
    }
    
    static func createInstance(builder: ActionSheet) -> ActionSheetController? {
        guard let result = UIStoryboard(name: "ActionSheet", bundle: Bundle(identifier: "org.cocoapods.ActionSheet")).instantiateViewController(withIdentifier: "ActionSheetController") as? ActionSheetController else {
            return nil
        }
        
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

public enum ActionButtonLocation {
    
    /// The primary container
    case body
    
    /// `ActiionButton`s set to bottom will dismiss the sheet when pressed
    case bottom
    
    case hero
}


public class ActionSheet {
    
    let title: String?
    let message: String?
    var presenter: ActionSheetPresenter? = ActionSheetPresenter()
    
    weak private var actionSheetController: ActionSheetController?
    
    public var primaryButtons = [ActionButton]()
    public var actionButtons = [ActionButton]()
    public var heroButtons = [ActionButton]()
    
    public init(title: String? = nil, message: String? = nil) {
        self.title = title
        self.message = message
    }
    
    public func present(_ presenter: UIViewController) {
        if let result = ActionSheetController.createInstance(builder: self) {
            self.actionSheetController = result
            result.modalPresentationStyle = .overFullScreen
            presenter.present(result, animated: false, completion: nil)
        }
    }
    
    public func addAction(location: ActionButtonLocation, _ actionButton: ActionButton) {
        switch location {
            
            case .body:
                actionButtons.append(actionButton)
            case .bottom:
                primaryButtons.append(actionButton)
            case .hero:
                heroButtons.append(actionButton)
        }
    }
    
    public func dismiss(){
        actionSheetController?.dismiss()
//        actionSheetController = nil
//        presenter = nil
//        primaryButtons.forEach({$0.removeFromSuperview()})
//        actionButtons.forEach({$0.removeFromSuperview()})
//        heroButtons.forEach({$0.removeFromSuperview()})
    }
    
    deinit {
        print("DEINIT - ACTIONSHEET")
    }
}
