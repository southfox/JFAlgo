//
//  ViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 09/06/2016.
//  Copyright (c) 2016 Javier Fuchs. All rights reserved.
//

import UIKit
import JFAlgo

class ViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var algorithms : [[String : AnyObject]] = [
          [
            "title" : JFAlgo.BinaryGap,
            "subtitle" : "Find longest sequence of zeros in binary representation of an integer."
          ],
          [
            "title" : JFAlgo.OddOccurrencesInArray,
            "subtitle" : "Find value that occurs in odd number of elements."
          ],
          [
            "title" : JFAlgo.CyclickRotation,
            "subtitle" : "Rotate an array to the right by a given number of steps."
          ],
          [
            "title" : JFAlgo.TapeEquilibrium,
            "subtitle" : "Minimize the value |(A[0] + ... + A[P-1]) - (A[P] + ... + A[N-1])|.",
          ],
          [
            "title" : JFAlgo.FrogJmp,
            "subtitle" : "Count minimal number of jumps from position X to Y."
          ],
          [
            "title" : JFAlgo.PermMissingElem,
            "subtitle" : "Find the missing element in a given permutation.",
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// UITableViewDelegate 
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("algorithms", forIndexPath: indexPath)
        let dict = algorithms[indexPath.row]
        
        if let textLabel = cell.textLabel,
           let detailTextLabel = cell.detailTextLabel,
           let title = dict["title"],
           let subtitle = dict["subtitle"] {
            textLabel.text = String(title)
            detailTextLabel.text = String(subtitle)
        }
        
        return cell
    }
    
    
    /// UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return algorithms.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dict = algorithms[indexPath.row]
        if let title = dict["title"] {
            let segue = String(title)
            self.performSegueWithIdentifier(segue, sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController
        vc.title = segue.identifier
    }
    
}

