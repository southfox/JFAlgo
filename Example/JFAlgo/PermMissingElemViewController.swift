//
//  PermMissingElemViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 9/8/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import JFAlgo

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
            self.showAlert("\(number) should be an odd integer within the range [2..1000000]", completion: closure)
           return
        }
        
        guard var array = A else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
           return
        }
        
        let solution = JFAlgo.PermMissingElem.solution(&array, N: number)
        if solution != -1 {
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
        
        if JFAlgo.PermMissingElem.checkDomainGenerator(number) == false {
            self.showAlert("\(number) should be an odd integer within the range [0..1000000]", completion: closure)
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