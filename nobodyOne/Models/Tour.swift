//
//  Tour.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import Foundation


class Tour: NSObject {
    
    let title: String?
    let citiesCount: Int?
    let concerts: [Concert]?
    
    init(_ dict: Dictionary<String, AnyObject>) {
        self.title = dict["title"] as? String
        self.citiesCount = dict["citiesCount"] as? Int
        var concerts = [Concert]()
        if let events = dict["events"] as? [Dictionary<String, AnyObject>] {
            for event in events {
                let concert = Concert(event)
                concerts.append(concert)
            }
        }
        self.concerts = concerts
    }
    
}
