//
//  Concert.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import Foundation

class Concert: NSObject {
    
    let city: String?
    let eventTimestamp: Int?
    let placeTitle: String?
    private let ticketsUrlString: String?
    let ticketsUrl: URL?
    
    init(_ dict: Dictionary<String, AnyObject>) {
        self.city = dict["city"] as? String
        self.eventTimestamp = dict["eventTimestamp"] as? Int
        self.placeTitle = dict["placeTitle"] as? String
        if let urlString = dict["ticketsUrl"] as? String {
            self.ticketsUrlString = urlString
            ticketsUrl = URL(string: urlString)
        } else { self.ticketsUrlString = nil; self.ticketsUrl = nil }
    }
    
}
