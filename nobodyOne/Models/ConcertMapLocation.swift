//
//  ConcertMapLocation.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 16.08.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import Foundation
import CoreLocation

class ConcertMapLocation: NSObject {
    
    private let rawLongitude: Double?
    private let rawLatitude: Double?
    let location: CLLocation?
    
    init(_ dict: Dictionary<String, AnyObject>) {
        if let lng = dict["lng"] as? Double, let lat = dict["lat"] as? Double {
            self.rawLongitude = lng
            self.rawLatitude = lat
            self.location = CLLocation(latitude: lat, longitude: lng)
        } else { self.rawLatitude = nil; self.rawLongitude = nil; self.location = nil }
    }
    
    
}
