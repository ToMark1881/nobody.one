//
//  Album.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import Foundation

class Album {
    
    let title: String?
    let year: Int?
    let additionalInfo: String?
    let coverImageName: String?
    let songs: [Song]?
    
    
    init(_ dict: Dictionary<String, AnyObject>) {
        self.title = dict["title"] as? String
        self.year = dict["year"] as? Int
        self.additionalInfo = dict["info"] as? String
        self.coverImageName = dict["imageName"] as? String
        var songs = [Song]()
        if let songsDict = dict["songs"] as? [Dictionary<String, AnyObject>] {
            for songDict in songsDict {
                let song = Song(songDict)
                songs.append(song)
            }
        }
        self.songs = songs
    }
    
}
