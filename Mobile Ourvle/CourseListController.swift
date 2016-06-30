//
//  CourseListController.swift
//  OurVLE
//
//  Created by Javon Davis on 7/30/15.
//  Copyright (c) 2015 Javon Davis. All rights reserved.
//

import UIKit

class CourseListController :UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var courseListTable: UITableView!
    
    var courses:Array<Course>?
    var items: [String] = ["We", "Heart", "Swift"]
    
    override func viewDidLoad() {
        
  
        
        //register the cell class
        self.courseListTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.courseListTable.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = self.courses![indexPath.row].shortname
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    
    }
    
}
