//
//  ActionButton.swift
//  ActionSheet
//
//  Created by William Connelly on 23/9/19.
//  Copyright © 2019 William Connelly. All rights reserved.
//

import Foundation
import UIKit

public  class ActionButton: UIView {
    
    /// The core style of the action button
    var style: ActionButtonStyle = .normal
    
    /// The text used in the label of the button
    var title: String = ""
    
    /// Callback when the button is pressed
    var handler: ((ActionButtonAction)->()) = {_ in}
    
    /// Image left of the label
    ///
    /// Only set when style is image
    var leftImage: UIImage? = nil
    @IBOutlet private var leftImageContainer: UIView?
    
    @IBOutlet var imageContainer: UIView!
    /// Image right of the label
    ///
    /// Only used when style is set to double
    var rightImage: UIImage? = nil
    @IBOutlet private var rightImageContainer: UIView?
    
    var contentView: UIView!
    
    var options: [ActionButtonOption: Any]?
    
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var subtitleLabel: UILabel?
    
    @IBOutlet weak var leftImageView: UIImageView?
    @IBOutlet weak var rightImageView: UIImageView?
    
    @IBOutlet var backgroundView: UIView?
    @IBOutlet var seperatorView: UIView?
    
    convenience init() {
        self.init(frame: CGRect.zero)
        commonInit()
    }
    
    public convenience init(title: String, style: ActionButtonStyle, options: [ActionButtonOption: Any]? = nil, handler: @escaping (ActionButtonAction) -> () = {_ in})  {
        self.init(frame: CGRect.zero)
        
        self.title = title
        self.style = style
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
        let bundle = Bundle(for: Self.self).url(forResource: "ActionSheet", withExtension: "bundle")!
        contentView = UINib(nibName: style.rawValue, bundle: Bundle(url: bundle)).instantiate(withOwner: self, options: nil).first as! ActionButton
        
        addSubview(contentView)
        seperatorView?.isHidden = true
        backgroundColor = UIColor.clear
        
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        viewDidLoad()
        setGestureRecognizers()
        setContraints()
    }
    
    private var isLeftPrimary: Bool {
        get {
            return (options?.first(where: {$0.0 == .leftPrimary})?.1 as? Bool) == true
        }
    }
    private func setGestureRecognizers(){
        if style == .double {
            if isLeftPrimary {
                imageContainer?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressPrimary(_:))))
                rightImageContainer?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressSecondary(_:))))
            } else {
                imageContainer?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressPrimary(_:))))
                leftImageContainer?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressSecondary(_:))))
            }
        } else {
            contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressPrimary(_:))))
        }
    }
    
    private func setContraints(){
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: contentView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView!, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView!, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: style == .hero ? 200 : 57)
        ])
    }
    
    open func viewDidLoad() {
        
        titleLabel?.text = title
        
        for (key, value) in options ?? [:] {
            switch key {
                
                case .fontTint:
                    if let tint = value as? UIColor {
                        titleLabel?.textColor = tint
                        subtitleLabel?.textColor = tint
                    }
                case .imageTint:
                    break
                case .images:
                    if style == .hero {
                        setHeroImage((value as? [UIImage])?.first)
                    } else if style == .image {
                        setLeftImage((value as? [UIImage])?.first)
                    } else if style == .double {
                        if let images = (value as? [UIImage]), images.count >= 2 {
                            setRightImage(images[1])
                        }
                    }
                case .leftPrimary:
                    break
                case .textAlignment:
                 break
            }
        }
    }
    
    private func setHeroImage(_ image: UIImage?) {
        leftImageView?.image = image
    }
    
    private func setLeftImage(_ image: UIImage?) {
        leftImageView?.image = image
    }
    
    private func setRightImage(_ image: UIImage?) {
        rightImageView?.image = image
    }
    
    @objc func didPressPrimary(_ sender: Any) {
        handler(.primary)
    }
    @objc func didPressSecondary(_ sender: Any) {
        handler(.secondary)
    }
}

