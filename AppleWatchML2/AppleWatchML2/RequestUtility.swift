//
//  RequestUtility.swift
//  AppleWatchML2
//
//  Created by ApplETS on 2015-11-21.
//  Copyright © 2015 Samuel Bellerose. All rights reserved.
//

import Alamofire
import SwiftyJSON

class RequestUtility {
    
    let headers = [
        "accept": "application/json"
    ]
    
    let url = "http://maisonlogiciellibre.org/projects?length=100"
    
    var projectsList = [Project]()
    
    func getProjects() -> Array<Project> {
        
        Alamofire.request(.GET, "http://maisonlogiciellibre.org/projects?length=100", headers:headers)
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        
                        let dataJSON:JSON = json["data"]
                        
                        //If json is .Dictionary
                        for (_,subJson):(String, JSON) in dataJSON {
                            
                            let project = Project.init(id: subJson["id"].string!, name: subJson["name"].string!, link: subJson["link"].string!)
                            self.projectsList.append(project)
                        }
                        
                        print("JSON: \(json)")
                        
                        
                    }
                case .Failure(let error):
                    print(error)
                }
                
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                
        
        }
        
        
        
        return projectsList
    }
    
    
    
    }