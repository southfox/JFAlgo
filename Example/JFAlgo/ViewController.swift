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
    var currentAlgorithm : Int?
    
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
        let dict = JFAlgo.algorithms[indexPath.row]
        
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
        return JFAlgo.algorithms.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentAlgorithm = indexPath.row
        let dict = JFAlgo.algorithms[indexPath.row]
        
        if let segue = dict["segue"] {
            self.performSegueWithIdentifier(String(segue), sender: self)
        }
        else if let title = dict["title"] {
            let segue = String(title)
            self.performSegueWithIdentifier(segue, sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController
        
        if let row = currentAlgorithm {
            let dict = JFAlgo.algorithms[row]
            if let title = dict["title"] {
                vc.title = String(title)
            }
        }
    }
    
}

