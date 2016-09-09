//
//  BaseCollectionViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 9/8/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class BaseCollectionViewController : BaseViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var A : [Int]?
    
    lazy var closure : (()->())? = { [weak self] in
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

        numberField.endEditing(true)
        handleTap()
        
        runButton.enabled = false
    }
    
    @IBAction func generateAction(sender: AnyObject) {
        numberField.endEditing(true)
        generateButton.enabled = false
    }
    
    func reload() {
        
        self.collectionView.reloadData()
        
        self.generateButton.enabled = true
        self.runButton.enabled = false
        if let a = A {
            self.runButton.enabled = a.count > 0 ? true : false
        }
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