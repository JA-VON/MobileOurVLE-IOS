//
//  RestCall.swift
//  OurVLE
//
//  Created by Javon Davis on 7/23/15.
//  Copyright (c) 2015 Javon Davis. All rights reserved.
//

import Foundation

class RestCall
{
    
    let url: String
    let params: [String:AnyObject]
    
    init(url:String,params:[String : AnyObject])
    {
        self.url = url
        self.params = params
        
        println("URL passed:\(url)")
    }
    
    convenience init(params:[String : String])
    {
        self.init(url: MoodleRestFunctions.URL,params: params)
    }

    
    func call(callback:(NSData?,String?) -> Void)
    {
        var urlParams = ""
        
        for key in params.keys
        {
            urlParams+="\(key)=\(params[key]!)&"
        }
        
        urlParams = urlParams.substringToIndex(urlParams.endIndex.predecessor())
        
        let finalUrl = url+"?"+urlParams
        
        println("final \(finalUrl)");
        
        let mUrl = NSURL(string: finalUrl)
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(mUrl!) {(data, response, error)-> Void in
            if error != nil {
                callback(nil, error.localizedDescription)
            } else {
                //var result = NSString(data: data, encoding:NSUTF8StringEncoding)!
                callback(data, nil)
            }
        }
        
        
        
        task.resume()
    }
    
}
