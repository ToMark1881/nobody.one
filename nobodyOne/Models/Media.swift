//
//  Media.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 08.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import Foundation

class Media {
    
    let title: String?
    let safariUrl: URL?
    let appUrl: URL?
    
    private let safariUrlString: String?
    private let appUrlString: String?
    
    init(_ dict: Dictionary<String, AnyObject>) {
        self.title = dict["title"] as? String
        if let safariUrlStr = dict["url"] as? String {
            self.safariUrlString = safariUrlStr
            safariUrl = URL(string: safariUrlStr)
        } else { safariUrlString = nil; safariUrl = nil }
        if let applicationUrlString = dict["applicationUrl"] as? String {
            self.appUrlString = applicationUrlString
            appUrl = URL(string: applicationUrlString)
        } else { appUrlString = nil; appUrl = nil }
    }
    
}
