//
//  ActionSheet.swift
//  ActionSheet
//
//  Created by William Connelly on 16/9/19.
//  Copyright © 2019 William Connelly. All rights reserved.
//

import Foundation
import UIKit

internal class ActionSheetController: UIViewController {
    @IBOutlet var backgroundView: UIView!
    
    /// insert new items at index 0 to mainContainer
    @IBOutlet  var mainContainer: UIStackView?
    
    @IBOutlet  var primaryButtonContainer: UIStackView?
    @IBOutlet  var actionButtonContainer: UIStackView?
    
    override func viewDidLoad() {
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
    
    private var titleText: String?
    private var subtitleText: String?
    private var actionButtons = [ActionButton]()
    private var primaryButtons = [ActionButton]()
    private var heroButtons = [ActionButton]()
    
    func dismiss() {
        animateOut()
    }
    
    func animateIn() {
    }
    
    @objc func animateOut(_ sender: Any? = nil) {
        dismiss(animated: true, completion: nil)
    }
    
    static func createInstance(builder: ActionSheet) -> ActionSheetController? {
        guard let result = UIStoryboard(name: "ActionSheet", bundle: Bundle(identifier: "ActionSheet")).instantiateViewController(withIdentifier: "ActionSheetController") as? ActionSheetController else {
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

enum ActionButtonLocation {
    
    /// The primary container
    case body
    
    /// `ActiionButton`s set to bottom will dismiss the sheet when pressed
    case bottom
    
    case hero
}


class ActionSheet {
    
    let title: String?
    let message: String?
    let presenter = ActionSheetPresenter()
    
    weak private var actionSheetController: ActionSheetController?
    
    internal var primaryButtons = [ActionButton]()
    internal var actionButtons = [ActionButton]()
    internal var heroButtons = [ActionButton]()
    
    init(title: String? = nil, message: String? = nil) {
        self.title = title
        self.message = message
    }
    
    func present(_ presenter: UIViewController) {
        if let result = ActionSheetController.createInstance(builder: self) {
            self.actionSheetController = result
            result.transitioningDelegate = self.presenter
            result.modalPresentationStyle = .overCurrentContext
            presenter.present(result, animated: true, completion: nil)
        }
    }
    
    func addAction(location: ActionButtonLocation, _ actionButton: ActionButton) {
        switch location {
            
            case .body:
                actionButtons.append(actionButton)
            case .bottom:
                primaryButtons.append(actionButton)
            case .hero:
                heroButtons.append(actionButton)
        }
    }
    
    func dismiss(){
        actionSheetController?.dismiss()
        actionSheetController = nil
    }
    
    deinit {
        print("DEINIT - ACTIONSHEET")
    }
}
