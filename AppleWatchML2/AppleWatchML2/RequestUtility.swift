//
//  RequestUtility.swift
//  AppleWatchML2
//
//  Created by ApplETS on 2015-11-21.
//  Copyright © 2015 Samuel Bellerose. All rights reserved.
//

import Alamofire

class RequestUtility {
    
    let headers = [
        "accept": "application/json"
    ]
    
    let url = "http://maisonlogiciellibre.org/projects?length=100"
    
    var projects = [Project]()
    
    func getProjects() -> Array<Project> {
        
        Alamofire.request(.GET, "http://maisonlogiciellibre.org/projects?length=100", headers:headers)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
        
        return projects
    }
    
    
    
    }