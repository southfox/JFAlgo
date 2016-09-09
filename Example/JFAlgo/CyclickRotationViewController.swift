//
//  CyclickRotationViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 9/7/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import JFAlgo

// A zero-indexed array A consisting of N integers is given. Rotation of the array means that each element is shifted right by one index, and the last element of the array is also moved to the first place.
//
// For example, the rotation of array A = [3, 8, 9, 7, 6] is [6, 3, 8, 9, 7]. The goal is to rotate array A K times; that is, each element of A will be shifted to the right by K indexes.
//
// Write a function:
//
// public func solution(inout A : [Int], _ K : Int) -> [Int]
// that, given a zero-indexed array A consisting of N integers and an integer K, returns the array A rotated K times.
//
// For example, given array A = [3, 8, 9, 7, 6] and K = 3, the function should return [9, 7, 6, 3, 8].
//
// Assume that:
//
// N and K are integers within the range [0..100];
// each element of array A is an integer within the range [−1,000..1,000].
// In your solution, focus on correctness. The performance of your solution will not be the focus of the assessment.

class CyclickRotationViewController : BaseCollectionViewController {
    
    @IBOutlet weak var cyclesField: UITextField!
    let cyclickRotation = CyclickRotation()
    
    @IBAction override func runAction() {
        super.runAction()
        
        guard let text = numberField.text,
            number = Int(text) else {
                return
        }
        
        guard let cycles = cyclesField.text,
            numberOfCycles = Int(cycles) else {
                return
        }
        
        numberField.endEditing(true)
        
        if cyclickRotation.checkDomainGenerator(number) == false {
            self.showAlert(cyclickRotation.domainErrorMessage()) { [weak self] in
                if let strong = self {
                    if let cl = strong.closure {
                        cl()
                    }
                    if let nf = strong.numberField {
                        nf.becomeFirstResponder()
                    }
                }
            }
           return
        }
        
        if cyclickRotation.checkDomainGenerator(numberOfCycles) == false {
            self.showAlert(cyclickRotation.domainErrorMessage()) { [weak self] in
                if let strong = self {
                    if let cl = strong.closure {
                        cl()
                    }
                    if let cf = strong.cyclesField {
                        cf.becomeFirstResponder()
                    }
                }
            }
            return
        }
        
        guard var array = A else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
            return
        }
        
        cyclickRotation.solution(&array, numberOfCycles)
        A = array
        self.collectionView.reloadData()
        runButton.enabled = true
    }
    
    @IBAction override func generateAction(sender: AnyObject) {
        super.generateAction(sender)
        
        guard let text = numberField.text,
            number = Int(text) else {
            return
        }
        
        cyclesField.endEditing(true)
        
        if cyclickRotation.checkDomainGenerator(number) == false {
            self.showAlert(cyclickRotation.domainErrorMessage()) { [weak self] in
                if let strong = self {
                    if let cl = strong.closure {
                        cl()
                    }
                    if let nf = strong.numberField {
                        nf.becomeFirstResponder()
                    }
                }
            }
           return
        }
        
        guard let array = cyclickRotation.generateDomain(number) else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
            return
        }
        
        A = array
        self.reload()
    }
    
}
