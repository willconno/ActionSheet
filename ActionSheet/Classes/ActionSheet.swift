//
//  ActionSheet.swift
//  ActionSheet
//
//  Created by William Connelly on 16/9/19.
//  Copyright © 2019 William Connelly. All rights reserved.
//

import Foundation
import UIKit

public class ActionSheet {
    
    var title: String?
    var message: String?
    
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
    
    public func dismiss(_ completionHandler: @escaping (() -> Void) = {}){
        actionSheetController?.dismiss() {
            self.removeReferences()
            completionHandler()
        }
    }
    
    private func removeReferences(){
        self.primaryButtons = []
        self.actionButtons = []
        self.heroButtons = []
    }
    
    deinit {
        print("DEINIT - ACTIONSHEET")
    }
}
