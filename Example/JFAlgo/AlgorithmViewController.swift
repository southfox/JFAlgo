//
//  AlgorithmViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 9/10/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import JFAlgo

class AlgorithmViewController : BaseCollectionViewController {
    
    internal var currentAlgorithm : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if  let dict = currentAlgorithmDict(),
            let title = dict["title"] {
            self.title = String(title)
        }
    }
    
    func currentAlgorithmDict() -> [String : AnyObject]? {
        if let n = currentAlgorithm {
            let dict = JFAlgo.algorithms[n]
            return dict
        }
        return nil
    }
    
    @IBAction override func runAction() {
        super.runAction()
        
        guard let text = numberField.text,
            number = Int(text) else {
            return
        }
        
        guard let dict = currentAlgorithmDict(),
              let algo = dict["algorithm"] else {
              return
        }
        
        let algorithm = algo as! Algorithm
        
        if algorithm.checkDomainGenerator(number) == false {
            self.showAlert(algorithm.domainErrorMessage(), completion: closure)
           return
        }
        
        guard var array = A else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
           return
        }
        
        let solution = algorithm.solution(&array)
        if solution != 0 {
            self.showAlert("\(number) generates an array with 1 unpaired element \(solution).", completion: closure)
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
        
        guard let dict = currentAlgorithmDict(),
              let algo = dict["algorithm"] else {
              return
        }
        let algorithm = algo as! Algorithm
        
        if algorithm.checkDomainGenerator(number) == false {
            self.showAlert(algorithm.domainErrorMessage(), completion: closure)
           return
        }
        
        guard let array = algorithm.generateDomain(number) else {
            self.showAlert("\(number) generates a nil array.", completion: closure)
           return
        }
        
        A = array
        self.reload()
    }
    
}