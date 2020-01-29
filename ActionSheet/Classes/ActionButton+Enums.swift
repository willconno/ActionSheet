//
//  ActionButton+Enums.swift
//  ActionSheet
//
//  Created by William Connelly on 28/1/20.
//

import Foundation

public enum ActionButtonAction {
    case primary, secondary
}

public enum ActionButtonTextLocation {
    case top, middle, bottom
}

public enum ActionButtonOption {
    case fontTint
    
    /// Image tint will only be used if the `style` of `ActionButton` is set to the `ActionButtonStyle` `image` or `double`
    case imageTint
    
    /// Images can only be used if `style` of `ActionButton` is set to the `ActionButtonStyle` `image` or `double`
    /// Images are always applied left to right regardless of `leftPrimary` option
    case images
    
    /// When `style` of `ActionButton` is set to the `ActionButtonStyle` `double` this will set which button returns `ActionButtonAction.primary` in the completion handler
    /// default is false
    case leftPrimary
    
    /// Hero image text location. Default is `UITextAlignment.center`
    case textAlignment
    
    /// Hero image text location. Default is `ActionButtonTextLocation.center`
    case textLocation
    
    /// `NSAttributedString` for Hero image text
    case attributedText
}

public enum ActionButtonStyle: String {
    /// Displays a diclosure indicator to the right of the label
    case disclosure = "ActionButtonDisclosure"
    /// Adds an optional image to the left of the label
    case image = "ActionButtonImage"
    /// Adds buttons to the right and left of the of label with seperate handlers
    case double = "ActionButtonDouble"
    /// Simple button with a centered label
    case normal = "ActionButtonNormal"
    /// Used primarily for the primary actions which sit below the action buttons
    case prominent = "ActionButtonProminent"
    /// Hero Image
    case hero = "ActionButtonHeader"
}
