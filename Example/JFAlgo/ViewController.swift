//
//  ViewController.swift
//  JFAlgo
//
//  Created by Javier Fuchs on 09/06/2016.
//  Copyright (c) 2016 Javier Fuchs. All rights reserved.
//

import UIKit
import JFAlgo

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var algorithms = [ JFAlgo.BinaryGap ]
    
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
        
        if let textLabel = cell.textLabel {
            textLabel.text = NSStringFromClass(algorithms[indexPath.row])
        }
        
        return cell
    }
    
    
    /// UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return algorithms.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(NSStringFromClass(algorithms[indexPath.row]), sender: self)
    }
    
}

