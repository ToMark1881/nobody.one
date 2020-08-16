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
    private let tourImageUrlString: String?
    let tourImageUrl: URL?
    let tourInfo: String?
    let concerts: [Concert]?
    
    init(_ dict: Dictionary<String, AnyObject>) {
        self.title = dict["title"] as? String
        self.citiesCount = dict["citiesCount"] as? Int
        self.tourInfo = (dict["tourInfo"] as? String)?.replacingOccurrences(of: "\\n", with: "\n")
        if let urlString = dict["tourImageUrl"] as? String {
            self.tourImageUrlString = urlString
            tourImageUrl = URL(string: urlString)
        } else { self.tourImageUrlString = nil; self.tourImageUrl = nil }
        var concerts = [Concert]()
        if let events = dict["events"] as? [Dictionary<String, AnyObject>] {
            for event in events {
                let concert = Concert(event)
                concert.tourImageUrl = self.tourImageUrl
                concerts.append(concert)
            }
        }
        self.concerts = concerts
        super.init()
        
        concerts.forEach({ $0.tour = self })
    }
    
}
