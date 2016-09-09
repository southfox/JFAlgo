//
//  PermCheckViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 9/8/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import JFAlgo

/// Check whether array A is a permutation.

/// A non-empty zero-indexed array A consisting of N integers is given.
///
/// A permutation is a sequence containing each element from 1 to N once, and only once.
///
/// For example, array A such that:
///
/// A[0] = 4
/// A[1] = 1
/// A[2] = 3
/// A[3] = 2
/// is a permutation, but array A such that:
///
/// A[0] = 4
/// A[1] = 1
/// A[2] = 3
/// is not a permutation, because value 2 is missing.
///
/// The goal is to check whether array A is a permutation.
///
/// Write a function:
///
/// public func solution(inout A : [Int]) -> Int
/// that, given a zero-indexed array A, returns 1 if array A is a permutation and 0 if it is not.
///
/// For example, given array A such that:
///
/// A[0] = 4
/// A[1] = 1
/// A[2] = 3
/// A[3] = 2
/// the function should return 1.
///
/// Given array A such that:
///
/// A[0] = 4
/// A[1] = 1
/// A[2] = 3
/// the function should return 0.
///
/// Assume that:
///
/// N is an integer within the range [1..100,000];
/// each element of array A is an integer within the range [1..1,000,000,000].
/// Complexity:
///
/// expected worst-case time complexity is O(N);
/// expected worst-case space complexity is O(N), beyond input storage (not counting the storage required for input arguments).
/// Elements of input arrays can be modified.


class PermCheckViewController : BaseCollectionViewController {
    
    let permCheck = PermCheck()
    
    @IBAction override func runAction() {
        super.runAction()
        
        guard let text = numberField.text,
            number = Int(text) else {
            return
        }
        
        if permCheck.checkDomainGenerator(number) == false {
            self.showAlert(permCheck.domainErrorMessage(), completion: closure)
           return
        }
        
        guard var array = A else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
           return
        }
        
        let solution = permCheck.solution(&array, N: number)
        if solution == 0 {
            self.showAlert("Fail: array is NOT a permutation.", completion: closure)
        }
        else {
            self.showAlert("Success: array is a permutation", completion: closure)
        }
    }
    
    @IBAction override func generateAction(sender: AnyObject) {
        super.generateAction(sender)
        
        guard let text = numberField.text,
            number = Int(text) else {
            return
        }
        
        if permCheck.checkDomainGenerator(number) == false {
            self.showAlert(permCheck.domainErrorMessage(), completion: closure)
           return
        }
        
        guard let array = permCheck.generateDomain(number) else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
           return
        }
        
        A = array
        self.reload()
    }
    
}
