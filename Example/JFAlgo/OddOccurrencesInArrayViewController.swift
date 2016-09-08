//
//  OddOccurrencesInArrayViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 9/7/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import JFAlgo

//  A non-empty zero-indexed array A consisting of N integers is given. The array contains an odd number of elements, and each element of the array can be paired with another element that has the same value, except for one element that is left unpaired.
//
//  For example, in array A such that:
//
//  A[0] = 9  A[1] = 3  A[2] = 9
//  A[3] = 3  A[4] = 9  A[5] = 7
//  A[6] = 9
//  the elements at indexes 0 and 2 have value 9,
//  the elements at indexes 1 and 3 have value 3,
//  the elements at indexes 4 and 6 have value 9,
//  the element at index 5 has value 7 and is unpaired.
//  Write a function:
//
//  public func solution(inout A : [Int]) -> Int
//  that, given an array A consisting of N integers fulfilling the above conditions, returns the value of the unpaired element.
//
//  For example, given array A such that:
//
//  A[0] = 9  A[1] = 3  A[2] = 9
//  A[3] = 3  A[4] = 9  A[5] = 7
//  A[6] = 9
//  the function should return 7, as explained in the example above.
//
//  Assume that:
//
//  N is an odd integer within the range [1..1,000,000];
//  each element of array A is an integer within the range [1..1,000,000,000];
//  all but one of the values in A occur an even number of times.
//  Complexity:
//
//  expected worst-case time complexity is O(N);
//  expected worst-case space complexity is O(1), beyond input storage (not counting the storage required for input arguments).
//  Elements of input arrays can be modified.

class OddOccurrencesInArrayViewController : BaseViewController, UITextFieldDelegate, UICollectionViewDataSource {
    
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
        if JFAlgo.OddOccurrencesInArray.checkDomainGenerator(number) == false {
            self.showAlert("Odd Ocurrences in Array", message: "\(number) should be an odd integer within the range [1..1000000]", completion: closure)
           return
        }
        
        guard var array = A else {
            self.showAlert("Odd Ocurrences in Array", message: "\(number) generates a nil array.", completion: closure)
           return
        }
        
        let solution = JFAlgo.OddOccurrencesInArray.solution(&array)
        if solution != 0 {
            self.showAlert("Odd Ocurrences in Array", message: "\(number) generates an array with 1 unpaired element \(solution).", completion: closure)
        }
        else {
            self.showAlert("Odd Ocurrences in Array", message: "No Solution for \(number)", completion: closure)
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
        
        if JFAlgo.OddOccurrencesInArray.checkDomainGenerator(number) == false {
            self.showAlert("Odd Ocurrences in Array", message: "\(number) should be an odd integer within the range [1..1000000]", completion: closure)
           return
        }
        
        guard let array = JFAlgo.OddOccurrencesInArray.generateDomain(number) else {
            self.showAlert("Odd Ocurrences in Array", message: "\(number) generates a nil array.", completion: closure)
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
