//
//  ViewController.swift
//  ActionSheet
//
//  Created by William Connelly on 01/21/2020.
//  Copyright (c) 2020 William Connelly. All rights reserved.
//

import UIKit
import ActionSheet

class ViewController: UIViewController {
    
    @IBAction func didSelectMine(_ sender: Any) {
        let sheet = ActionSheet(title: "This is the title of the view. Lets try to make is spill over two lines. A little more to be sure.",
                                message: "Message can go here. I might make this go over two lines too. Lets see if this is enough chars.")
        
//        sheet.addAction(location: .bottom, ActionButton(title: "Edit", style: .prominent, options: [.fontTint : UIColor.red], handler: { action in
//            self.showAlert("Prominent button pressed.")
//        }))
        sheet.addAction(location: .bottom, ActionButton(title: "Cancel", style: .prominent, handler: { action in
            sheet.dismiss()
        }))
        
//        sheet.addAction(location: .body, ActionButton(title: "Image Button", style: .image, handler: { action in
//            self.showAlert("Image button pressed.")
//        }))
//
//        sheet.addAction(location: .body, ActionButton(title: "Double Button", style: .double, options: [.leftPrimary: false], handler: { action in
//            if action == .primary {
//                self.showAlert("Primary button pressed.")
//            } else {
//                self.showAlert("Secondary button pressed.")
//            }
//        }))
        
//        sheet.addAction(location: .body, ActionButton(title: "Disclosure Button", style: .disclosure, handler: { action in
//            self.showAlert("Disclosure button pressed.")
//        }))
        
        sheet.addAction(location: .body, ActionButton(title: "Normal Button", style: .normal, handler: { action in
            self.showAlert("Normal button pressed.")
        }))
        sheet.addAction(location: .body, ActionButton(title: "Desctructive Button", style: .normal, options: [.fontTint : UIColor.red], handler: { action in
            self.showAlert("Prominent button pressed.")
        }))
        
//        let font = UIFont.systemFont(ofSize: 17, weight: .bold)
//        let attributed = NSMutableAttributedString(string: "Bottom left and system 17pt bold.", attributes: [.font:font])
//
//        sheet.addAction(location: .hero, ActionButton(title: "Attributed", style: .hero, options: [.textLocation: ActionButtonTextLocation.bottom, .attributedText: attributed, .textAlignment: NSTextAlignment.left], handler: { action in
//            self.showAlert("Hero image pressed.")
//        }))
        
        sheet.present(self)
    }
    
    @IBAction func didSelectTheirs(_ sender: Any) {
        let controller = UIAlertController(title: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", message: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "Sample 1", style: .default, handler: nil))
        controller.addAction(UIAlertAction(title: "Sample 2", style: .default, handler: nil))
        controller.addAction(UIAlertAction(title: "Sample 4", style: .default, handler: nil))
        controller.addAction(UIAlertAction(title: "Sample 5", style: .default, handler: nil))
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
    
    func showAlert(_ title: String) {
        let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

