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


class PermMissingElemViewController : BaseViewController, UICollectionViewDataSource {
    
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
        if JFAlgo.PermMissingElem.checkDomainGenerator(number) == false {
            self.showAlert("\(number) should be an integer within the range [0..1000000]", completion: closure)
           return
        }
        
        guard var array = A else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
           return
        }
        
        let solution = JFAlgo.PermMissingElem.solution(&array, N: number)
        if solution != -1 {
            self.showAlert("array missing element is \(solution).", completion: closure)
        }
        else {
            self.showAlert("No Solution for \(number)", completion: closure)
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
        
        if JFAlgo.PermMissingElem.checkDomainGenerator(number) == false {
            self.showAlert("\(number) should be an integer within the range [0..1000000]", completion: closure)
           return
        }
        
        guard let array = JFAlgo.PermMissingElem.generateDomain(number) else {
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