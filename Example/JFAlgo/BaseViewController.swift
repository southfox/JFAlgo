//
//  BaseViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 9/7/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class BaseViewController : UIViewController {
    
    func showAlert(message: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: self.title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: completion)
    }
}