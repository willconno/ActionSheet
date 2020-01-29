//
//  ActionSheetTitleView.swift
//  ActionSheet
//
//  Created by William Connelly on 28/1/20.
//

import Foundation
import UIKit

open class ActionSheetTitleView: UIView {
    
    /// The text used in the label of the button
    var title: String?
    /// The text used in the label of the button
    var subtitle: String?
    
    /// Callback when the button is pressed
    var handler: ((ActionButtonAction)->()) = {_ in}
    
    var contentView: UIView!
    
    var options: [ActionButtonOption: Any]?
    
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var subtitleLabel: UILabel?
    
    convenience init() {
        self.init(frame: CGRect.zero)
        commonInit()
    }
    
    convenience init(title: String?, message: String?, options: [ActionButtonOption: Any]? = nil, handler: @escaping (ActionButtonAction) -> () = {_ in})  {
        self.init(frame: CGRect.zero)
        
        self.title = title
        self.subtitle = message
        self.handler = handler
        self.options = options
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        contentView = UINib(nibName: "ActionButtonTitle", bundle: Bundle(identifier: "org.cocoapods.ActionSheet")).instantiate(withOwner: self, options: nil).first as! ActionSheetTitleView
        
        addSubview(contentView)
        backgroundColor = UIColor.clear
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        viewDidLoad()
        setGestureRecognizers()
        setContraints()
    }
    
    private func setGestureRecognizers(){
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressPrimary(_:))))
    }
    
    private func setContraints(){
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: contentView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView!, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView!, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
        ])
    }
    
    open func viewDidLoad() {
        self.blur()
        
        titleLabel?.text = title
        subtitleLabel?.text = subtitle
        
        for (key, value) in options ?? [:] {
            switch key {
                
                case .fontTint:
                    if let tint = value as? UIColor {
                        titleLabel?.textColor = tint
                        subtitleLabel?.textColor = tint
                }
                
                default: break
            }
        }
    }
    
    @objc func didPressPrimary(_ sender: Any) {
        handler(.primary)
    }
    @objc func didPressSecondary(_ sender: Any) {
        handler(.secondary)
    }
}

