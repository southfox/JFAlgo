//
//  TapeEquilibriumViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 9/7/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import JFAlgo

// A non-empty zero-indexed array A consisting of N integers is given. Array A represents numbers on a tape.
//
// Any integer P, such that 0 < P < N, splits this tape into two non-empty parts: A[0], A[1], ..., A[P − 1] and A[P], A[P + 1], ..., A[N − 1].
//
// The difference between the two parts is the value of: |(A[0] + A[1] + ... + A[P − 1]) − (A[P] + A[P + 1] + ... + A[N − 1])|
//
// In other words, it is the absolute difference between the sum of the first part and the sum of the second part.
//
// For example, consider array A such that:
//
// A[0] = 3
// A[1] = 1
// A[2] = 2
// A[3] = 4
// A[4] = 3
// We can split this tape in four places:
//
// P = 1, difference = |3 − 10| = 7
// P = 2, difference = |4 − 9| = 5
// P = 3, difference = |6 − 7| = 1
// P = 4, difference = |10 − 3| = 7
// Write a function:
//
// public func solution(inout A : [Int]) -> Int
// that, given a non-empty zero-indexed array A of N integers, returns the minimal difference that can be achieved.
//
// For example, given:
//
// A[0] = 3
// A[1] = 1
// A[2] = 2
// A[3] = 4
// A[4] = 3
// the function should return 1, as explained above.
//
// Assume that:
//
// N is an integer within the range [2..100,000];
// each element of array A is an integer within the range [−1,000..1,000].
// Complexity:
//
// expected worst-case time complexity is O(N);
// expected worst-case space complexity is O(N), beyond input storage (not counting the storage required for input arguments).
// Elements of input arrays can be modified.


class TapeEquilibriumViewController : BaseViewController, UICollectionViewDataSource {
    
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
        if JFAlgo.TapeEquilibrium.checkDomainGenerator(number) == false {
            self.showAlert("\(number) should be an odd integer within the range [2..1000000]", completion: closure)
           return
        }
        
        guard var array = A else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
           return
        }
        
        let solution = JFAlgo.TapeEquilibrium.solution(&array)
        if solution != 0 {
            self.showAlert("\(number) generates Array with minimal difference achieved in \(solution).", completion: closure)
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
        
        if JFAlgo.TapeEquilibrium.checkDomainGenerator(number) == false {
            self.showAlert("\(number) should be an odd integer within the range [2..1000000]", completion: closure)
           return
        }
        
        guard let array = JFAlgo.TapeEquilibrium.generateDomain(number) else {
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