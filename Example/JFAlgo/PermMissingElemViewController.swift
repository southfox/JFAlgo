//
//  PermMissingElemViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 9/8/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import JFAlgo
/// A zero-indexed array A consisting of N different integers is given. The array contains integers in the range [1..(N + 1)], which means that exactly one element is missing.
///
/// Your goal is to find that missing element.
///
/// Write a function:
///
/// int solution(int A[], int N);
/// that, given a zero-indexed array A, returns the value of the missing element.
///
/// For example, given array A such that:
///
/// A[0] = 2
/// A[1] = 3
/// A[2] = 1
/// A[3] = 5
/// the function should return 4, as it is the missing element.
///
/// Assume that:
///
/// N is an integer within the range [0..100,000];
/// the elements of A are all distinct;
/// each element of array A is an integer within the range [1..(N + 1)].
/// Complexity:
///
/// expected worst-case time complexity is O(N);
/// expected worst-case space complexity is O(1), beyond input storage (not counting the storage required for input arguments).
/// Elements of input arrays can be modified.


class PermMissingElemViewController : BaseCollectionViewController {
    
    let permMissingElem = PermMissingElem()
    
    @IBAction override func runAction() {
        super.runAction()
        
        guard let text = numberField.text,
            number = Int(text) else {
            return
        }
        
        if permMissingElem.checkDomainGenerator(number) == false {
            self.showAlert(permMissingElem.domainErrorMessage(), completion: closure)
           return
        }
        
        guard var array = A else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
           return
        }
        
        let solution = permMissingElem.solution(&array, N: number)
        if solution != -1 {
            self.showAlert("array missing element is \(solution).", completion: closure)
        }
        else {
            self.showAlert("No Solution for \(number)", completion: closure)
        }
    }
    
    @IBAction override func generateAction(sender: AnyObject) {
        super.generateAction(sender)
        
        guard let text = numberField.text,
            number = Int(text) else {
            return
        }
        
        if permMissingElem.checkDomainGenerator(number) == false {
            self.showAlert(permMissingElem.domainErrorMessage(), completion: closure)
           return
        }
        
        guard let array = permMissingElem.generateDomain(number) else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
           return
        }
        
        A = array
        self.reload()
    }
    
}
