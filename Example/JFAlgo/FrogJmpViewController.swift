//
//  FrogJmpViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 9/8/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import JFAlgo

/// A small frog wants to get to the other side of the road. The frog is currently located at position X and wants to get to a position greater than or equal to Y. The small frog always jumps a fixed distance, D.

/// Count the minimal number of jumps that the small frog must perform to reach its target.
///
/// Write a function:
///
/// public func solution(X : Int, _ Y : Int, _ D : Int) -> Int
/// that, given three integers X, Y and D, returns the minimal number of jumps from position X to a position equal to or greater than Y.
///
/// For example, given:
///
/// X = 10
/// Y = 85
/// D = 30
/// the function should return 3, because the frog will be positioned as follows:
///
/// after the first jump, at position 10 + 30 = 40
/// after the second jump, at position 10 + 30 + 30 = 70
/// after the third jump, at position 10 + 30 + 30 + 30 = 100
/// Assume that:
///
/// X, Y and D are integers within the range [1..1,000,000,000];
/// X ≤ Y.
/// Complexity:
///
/// expected worst-case time complexity is O(1);
/// expected worst-case space complexity is O(1).


class FrogJmpViewController : BaseViewController {
    
    @IBOutlet weak var xField: UITextField!
    @IBOutlet weak var yField: UITextField!
    @IBOutlet weak var jumpField: UITextField!
    @IBOutlet weak var runButton: UIButton!
    
    let frogJmp = FrogJmp()
    
    @IBAction func runAction() {
        guard let xText = xField.text,
                x = Int(xText),
                yText = yField.text,
                y = Int(yText),
                jumpText = jumpField.text,
                jump = Int(jumpText) else {
            return
        }
        runButton.enabled = false
        for field in [xField, yField, jumpField] {
            field.resignFirstResponder()
        }
        for v in [x, y, jump] {
            if frogJmp.checkDomainGenerator(v) == false {
                self.showAlert(frogJmp.domainErrorMessage()) { [weak self] in
                    if let strong = self {
                        strong.runButton.enabled = true
                    }
                }
                return
            }
        }
        
        let solution = frogJmp.solution(x, y, jump)
        self.showAlert("x = \(x), y = \(y), jump = \(jump): Solution = \(solution)") { [weak self] in
            if let strong = self {
                strong.runButton.enabled = true
            }
        }
    }
}