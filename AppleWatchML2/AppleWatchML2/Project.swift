//
//  Project.swift
//  AppleWatchML2
//
//  Created by Samuel Bellerose on 2015-11-21.
//  Copyright © 2015 Samuel Bellerose. All rights reserved.
//

class Project {
    var id: String
    var name: String?
    var link: String?
    
    init(id: String, name: String, link:String) {
        self.id = id
        self.name = name
        self.link = link
    }
}