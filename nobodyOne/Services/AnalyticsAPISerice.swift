//
//  AnalyticsAPISerice.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 12.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import Foundation
import FirebaseAnalytics

protocol AnalyticsAPIInterface: class {
    
    func trackSelectedSong(_ name: String?)
    
    func trackSelectedAlbum(_ name: String?)
    
    func trackAlbumOpenedInAppleMusic(_ name: String?)
    
    func trackOpenTicketsStore(_ city: String?)
    
}

class FirebaseAPIAnalyticsService: AnalyticsAPIInterface {
    
    func trackSelectedSong(_ name: String?) {
        guard let name = name else { return }
        Analytics.logEvent("selectedSong", parameters: ["songTitle": name])
    }
    
    func trackSelectedAlbum(_ name: String?) {
        guard let name = name else { return }
        Analytics.logEvent("selectedAlbum", parameters: ["albumTitle": name])
        
    }
    
    func trackAlbumOpenedInAppleMusic(_ name: String?) {
        guard let name = name else { return }
        Analytics.logEvent("albumOpenedInAppleMusic", parameters: ["appleMusicAlbumTitle": name])
        
    }
    
    func trackOpenTicketsStore(_ city: String?) {
        guard let city = city else { return }
        Analytics.logEvent("openTickets", parameters: ["city": city])
    }
    
    
}
