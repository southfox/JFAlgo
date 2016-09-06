//
//  BinaryGapViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 9/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import JFAlgo

public class BinaryGapViewController : UIViewController {
    
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var runButton: UIButton!
    
    @IBAction func runAction() {
        guard let text = numberField.text,
            number = Int(text) else {
            return
        }
        runButton.enabled = false
        let solution = JFAlgo.BinaryGap.solution(number)
        let alert = UIAlertController(title: "BinaryGap", message: "\(number): Solution = \(solution)", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true) { [weak self] in
            if let strong = self {
                strong.runButton.enabled = true
            }
        }
    }
}