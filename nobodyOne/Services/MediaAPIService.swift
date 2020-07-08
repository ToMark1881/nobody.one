//
//  MediaAPIService.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 08.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import Foundation

protocol MediaAPIInterface: class {
    
    func getMedia(completed: @escaping ([Media]) -> Void, failure: ((Error?) -> Void))
    
}

class MediaAPIService: MediaAPIInterface {
    
    func getMedia(completed: @escaping ([Media]) -> Void, failure: ((Error?) -> Void)) {
        if let url = Bundle.main.url(forResource: "media", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>,
                    let media = jsonResult["socialMedia"] as? [Dictionary<String, AnyObject>] {
                    parseMedia(dictionary: media, completed: completed)
                }
            } catch {
                failure(error)
            }
        }
    }
    
    fileprivate func parseMedia(dictionary: [Dictionary<String, AnyObject>], completed: @escaping ([Media]) -> Void) {
        var mediaObjects = [Media]()
        for event in dictionary {
            let media = Media(event)
            mediaObjects.append(media)
        }
        completed(mediaObjects)
    }
    
}
