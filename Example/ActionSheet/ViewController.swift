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
        let sheet = ActionSheet(title: "This is the title of the view. Lets try to make is spill over two lines. A little more to be sure.", message: "Message can go here. I might make this go over two lines too. Lets see if this is enough chars.")
        
        sheet.addAction(location: .bottom, ActionButton(title: "Edit", style: .prominent, options: [.fontTint : UIColor.red], handler: { action in
            print("Hello!")
        }))
//        sheet.addAction(location: .bottom, ActionButton(title: "Cancel", style: .prominent, handler: { action in
//            sheet.dismiss()
//        }))
//        
//        sheet.addAction(location: .body, ActionButton(title: "Option 1", style: .image, handler: { action in
//            print("awdawd!")
//        }))
//        sheet.addAction(location: .body, ActionButton(title: "Option 2", style: .double, options: [.leftPrimary: true],handler: { action in
//            if action == .primary {
//                print("Call")
//            } else {
//                print("SMS")
//            }
//        }))
//        sheet.addAction(location: .body, ActionButton(title: "Disclosure Button", style: .disclosure, handler: { action in
//            print("Disclosure button clicked!")
//        }))
//        sheet.addAction(location: .body, ActionButton(title: "Normal Button", style: .normal, handler: { action in
//            print("Normal button clicked!")
//        }))
//        sheet.addAction(location: .hero, ActionButton(title: "Center", style: .hero, options: [.images : [UIImage(named: "house")]], handler: { action in
//            print("Hero image clicked!")
//        }))
//        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

