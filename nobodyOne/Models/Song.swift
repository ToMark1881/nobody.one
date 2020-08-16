//
//  Song.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import Foundation

class Song: NSObject {
    
    let title: String?
    let timestamp: Int?
    let position: Int?
    
    init(_ dict: Dictionary<String, AnyObject>) {
        self.title = dict["title"] as? String
        self.timestamp = dict["timestamp"] as? Int
        self.position = dict["position"] as? Int
    }
    
}
