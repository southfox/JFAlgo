//
//  MissingIntegerViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 9/8/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import JFAlgo

/// Find the minimal positive integer not occurring in a given sequence.

/// Write a function:
///
/// public func solution(inout A : [Int]) -> Int
/// that, given a non-empty zero-indexed array A of N integers, returns the minimal positive integer (greater than 0) that does not occur in A.
///
/// For example, given:
///
/// A[0] = 1
/// A[1] = 3
/// A[2] = 6
/// A[3] = 4
/// A[4] = 1
/// A[5] = 2
/// the function should return 5.
///
/// Assume that:
///
/// N is an integer within the range [1..100,000];
/// each element of array A is an integer within the range [−2,147,483,648..2,147,483,647].
/// Complexity:
///
/// expected worst-case time complexity is O(N);
/// expected worst-case space complexity is O(N), beyond input storage (not counting the storage required for input arguments).
/// Elements of input arrays can be modified.


class MissingIntegerViewController : BaseCollectionViewController {
    
    let missingInteger = MissingInteger()
    
    @IBAction override func runAction() {
        super.runAction()
        
        guard let text = numberField.text,
            number = Int(text) else {
            return
        }
        
        if missingInteger.checkDomainGenerator(number) == false {
            self.showAlert(missingInteger.domainErrorMessage(), completion: closure)
            return
        }
        
        guard var array = A else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
            return
        }
        
        let solution = missingInteger.solution(&array, N: number)
        if solution != 0 {
            self.showAlert("SUCCESS: array missing integer is \(solution).", completion: closure)
        }
        else {
            self.showAlert("FAILURE: array has no missing integer", completion: closure)
        }
    }
    
    @IBAction override func generateAction(sender: AnyObject) {
        super.generateAction(sender)
        
        guard let text = numberField.text,
            number = Int(text) else {
            return
        }
        
        if missingInteger.checkDomainGenerator(number) == false {
            self.showAlert(missingInteger.domainErrorMessage(), completion: closure)
           return
        }
        
        guard let array = missingInteger.generateDomain(number) else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
           return
        }
        
        A = array
        self.reload()
    }
    
}
