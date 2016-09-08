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

class CyclickRotationViewController : BaseViewController, UITextFieldDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var cyclesField: UITextField!
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
                if let text = tf.text {
                    A![indexPath.row] = Int(text)!
                }
            }
        }
    }
    
    @IBAction func runAction() {
        guard let text = numberField.text,
            number = Int(text) else {
                return
        }
        
        guard let cycles = cyclesField.text,
            numberOfCycles = Int(cycles) else {
                return
        }
        
        numberField.endEditing(true)
        cyclesField.endEditing(true)
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
        if JFAlgo.CyclickRotation.checkDomainGenerator(number) == false {
            self.showAlert("\(number) should be within the range [1..100]", completion: closure)
            return
        }
        
        if JFAlgo.CyclickRotation.checkDomainGenerator(numberOfCycles) == false {
            self.showAlert("\(numberOfCycles) should be within the range [1..100]", completion: closure)
            return
        }
        
        guard var array = A else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
            return
        }
        
        JFAlgo.CyclickRotation.solution(&array, numberOfCycles)
        A = array
        self.collectionView.reloadData()
        runButton.enabled = true
    }
    
    @IBAction func generateAction(sender: AnyObject) {
        guard let text = numberField.text,
            number = Int(text) else {
                return
        }
        
        numberField.endEditing(true)
        cyclesField.endEditing(true)
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
        
        if JFAlgo.CyclickRotation.checkDomainGenerator(number) == false {
            self.showAlert("\(number) should be within the range [1..100]", completion: closure)
            return
        }
        
        guard let array = JFAlgo.CyclickRotation.generateDomain(number) else {
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