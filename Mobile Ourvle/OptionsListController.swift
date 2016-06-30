//
//  OptionsListController.swift
//  OurVLE
//
//  Created by Javon Davis on 8/10/15.
//  Copyright (c) 2015 Javon Davis. All rights reserved.
//

import UIKit

class OptionsListController: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var optionsTable: UITableView!
    
    var options:[String] = ["Courses","Forums","Feedback","Log Out"]
    
    override func viewDidLoad() {
        //register the cell class
        self.optionsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.optionsTable.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = self.options[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
}
