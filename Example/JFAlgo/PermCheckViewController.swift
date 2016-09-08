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

class PermCheckViewController : BaseViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var A : [Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
    }
    
    func handleTap() {
        
        for indexPath in self.collectionView.indexPathsForVisibleItems() {
            guard let cell = self.collectionView.cellForItemAtIndexPath(indexPath) else {
                continue
            }
            if let tf : UITextField = cell.contentView.subviews.first as? UITextField {
                tf.endEditing(true)
                if let text = tf.text,
                   let n = Int(text) {
                    A![indexPath.row] = n
                }
            }
        }
    }
    
    @IBAction func runAction() {
        guard let text = numberField.text,
            number = Int(text) else {
            return
        }
        
        numberField.endEditing(true)
        handleTap()
        
        let closure : (()->())? = { [weak self] in
            if let strong = self {
                if let array = strong.A {
                    strong.runButton.enabled = array.count > 0 ? true : false
                }
                else {
                    strong.runButton.enabled = false
                }
                strong.generateButton.enabled = true
            }
        }
        
        runButton.enabled = false
        if JFAlgo.PermCheck.checkDomainGenerator(number) == false {
            self.showAlert("\(number) should be an integer within the range [0..1000000]", completion: closure)
           return
        }
        
        guard var array = A else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
           return
        }
        
        let solution = JFAlgo.PermCheck.solution(&array, N: number)
        if solution == 0 {
            self.showAlert("Fail: array is NOT a permutation.", completion: closure)
        }
        else {
            self.showAlert("Success: array is a permutation", completion: closure)
        }
    }
    
    @IBAction func generateAction(sender: AnyObject) {
        guard let text = numberField.text,
            number = Int(text) else {
            return
        }
        
        numberField.endEditing(true)
        let closure : (()->())? = { [weak self] in
            if let strong = self {
                if let array = strong.A {
                    strong.runButton.enabled = array.count > 0 ? true : false
                }
                else {
                    strong.runButton.enabled = false
                }
                strong.generateButton.enabled = true
            }
        }
        
        generateButton.enabled = false
        
        if JFAlgo.PermCheck.checkDomainGenerator(number) == false {
            self.showAlert("\(number) should be an integer within the range [0..1000000]", completion: closure)
           return
        }
        
        guard let array = JFAlgo.PermCheck.generateDomain(number) else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
           return
        }
        
        A = array
        self.collectionView.reloadData()
        
        self.generateButton.enabled = true
        self.runButton.enabled = array.count > 0 ? true : false
    }
    
    /// UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let array = A {
            return array.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("odds", forIndexPath: indexPath)
        if let textfield : UITextField = cell.contentView.subviews.first as? UITextField,
           let array = A {
            textfield.text = String(array[indexPath.row])
        }
        return cell
    }
    
}