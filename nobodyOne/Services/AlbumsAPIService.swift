//
//  AlbumsAPIService.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import Foundation

protocol AlbumsAPIInterface: class {
    
    func getAlbums(completed: @escaping (([Album]) -> Void), failure: ((Error?)) -> Void)
    
}

class AlbumsAPIService: AlbumsAPIInterface {
    
    func getAlbums(completed: @escaping (([Album]) -> Void), failure: ((Error?)) -> Void) {
        if let url = Bundle.main.url(forResource: "albums-edited", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>,
                    let albums = jsonResult["albums"] as? [Dictionary<String, AnyObject>] {
                    parseAlbums(dictionary: albums, completed: completed)
                }
            } catch {
                failure(error)
            }
        }
    }
    
    
    fileprivate func parseAlbums(dictionary: [Dictionary<String, AnyObject>], completed: @escaping(([Album]) -> Void)) {
        var albums = [Album]()
        for event in dictionary {
            let album = Album(event)
            albums.append(album)
        }
        completed(albums)
    }
}
