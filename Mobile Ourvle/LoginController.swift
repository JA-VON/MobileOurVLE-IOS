//
//  ViewController.swift
//  OurVLE
//
//  Created by Javon Davis on 7/22/15.
//  Copyright (c) 2015 Javon Davis. All rights reserved.
//

import UIKit
import JSONJoy
import CoreData

class LoginController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    var dataFilePath: String?

    
    struct Courses : JSONJoy {
        var courses: Array<Course>?
        init() {
        }
        init(_ decoder: JSONDecoder) {
//            courses = decoder.getArray(&courses)
            //decoder.getArray(&courses)
            if let cdecs = decoder.array {
                courses = Array<Course>()
                for coursedecoder in cdecs {
                  //  courses?.append(Course(coursedecoder))
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(sender: UIButton) {
        var username = usernameField.text!
        var password = passwordField.text!
        var token:String?
        
        println("Username:\(username)")
        println("Password:\(password)")
        
        let uParams = ["username":username,"password":password,"service":MoodleRestFunctions.SERVICE_MOODLE_MOBILE]
        
        let restCall = RestCall(url: MoodleRestFunctions.URL+MoodleRestFunctions.LOGIN,params:uParams)
        usernameField.hidden = true
        passwordField.hidden = true
        loginButton.hidden = true
        spinner.hidden = false
        spinner.startAnimating()
        restCall.call(){
            (data, error) -> Void in
            if error != nil {
                println(error)
            } else {
                let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil)
                if let response = jsonObject as? NSDictionary{
                        if let object = response["token"] as? String{
                            
                            
                            token = object
                            self.getSiteInfo(token!)
                        }
                    }
            }
        }
        //self.performSegueWithIdentifier("showCourses",sender:"hello")
    }
    
    func saveUser()
    {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
    }
    
    func getSiteInfo(token: String)
    {
        
        let uParams = ["wstoken":token,"wsfunction":MoodleRestFunctions.FUNCTION_GET_SITE_INFO,"moodlewsrestformat":MoodleRestFunctions.RESPONSE_FORMAT]
        
        let restCall = RestCall(url: MoodleRestFunctions.URL+MoodleRestFunctions.REST_API,params:uParams)
        
        restCall.call(){
            (data, error) -> Void in
            if error != nil {
                println(error)
            } else {
                var result = NSString(data: data!, encoding:NSUTF8StringEncoding)!
                var jsonResult = result as String
                
                
                
               // var user = User(JSONDecoder(data!),mToken: token)
                //self.spinner.stopAnimating()
                println(jsonResult)
            
               // self.getCourses(token,userid: user.userid!)
            }
        }
    }
    
    func checkUser() {
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as! String
        dataFilePath =
            docsDir.stringByAppendingPathComponent("data.archive")
        
        if filemgr.fileExistsAtPath(dataFilePath!) {
            let dataArray =
            NSKeyedUnarchiver.unarchiveObjectWithFile(dataFilePath!)
                as! [String]
            usernameField.text = dataArray[0]
        }
    }
    
    func saveUser(user: User)
    {
//        var contactArray = [name.text, address.text, phone.text]
        NSKeyedArchiver.archiveRootObject(user,toFile: dataFilePath!)
    }
    
    func getCourses(token:String,userid:Int)
    {
        
        let uParams = ["wstoken":token,"wsfunction":MoodleRestFunctions.FUNCTION_GET_ENROLLED_COURSES,"moodlewsrestformat":MoodleRestFunctions.RESPONSE_FORMAT,"userid":"\(userid)"]
        
        let restCall = RestCall(url: MoodleRestFunctions.URL+MoodleRestFunctions.REST_API,params:uParams)
        
        restCall.call(){
            (data, error) -> Void in
            if error != nil {
                println(error)
            } else {
                var result = NSString(data: data!, encoding:NSUTF8StringEncoding)!
                var jsonResult = result as String
//                var siteInfo = SiteInfo(JSONDecoder(data!),mToken: token)
                var courses = Courses(JSONDecoder(data!))
                self.spinner.stopAnimating()
                println(jsonResult)
                
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    //self.performSegueWithIdentifier("showCourses",sender: courses.courses)
                    self.performSegueWithIdentifier("showHome",sender: courses.courses)
                }
            }
        }
    }
    
//    func showCourses()
//    {
//        self.performSegueWithIdentifier("showCourses",sender:"hello")
//    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if(segue.identifier == "showCourses")
//        {
//            let courseListVC:CourseListController = segue.destinationViewController as! CourseListController
//            
//            let data = sender as! Array<Course>
//            
//            courseListVC.courses = data
//        }
//    }

}

