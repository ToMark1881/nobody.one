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
    let youtubeUrl: URL?
    let appleMusicUrl: URL?
    let spotifyUrl: URL?
    let videoId: String?
    let songs: [Song]?
    
    private let youtubeUrlString: String?
    private let appleMusicUrlString: String?
    private let spotifyUrlString: String?
    
    
    init(_ dict: Dictionary<String, AnyObject>) {
        self.title = dict["title"] as? String
        self.year = dict["year"] as? Int
        self.additionalInfo = dict["info"] as? String
        self.coverImageName = dict["imageName"] as? String
        self.videoId = dict["videoID"] as? String
        var songs = [Song]()
        if let songsDict = dict["songs"] as? [Dictionary<String, AnyObject>] {
            for songDict in songsDict {
                let song = Song(songDict)
                songs.append(song)
            }
        }
        self.songs = songs
        if let urlString = dict["link"] as? String {
            self.youtubeUrlString = urlString
            self.youtubeUrl = URL(string: urlString)
        } else { self.youtubeUrlString = nil; self.youtubeUrl = nil }
        
        if let urlString = dict["appleMusicUrl"] as? String {
            self.appleMusicUrlString = urlString
            self.appleMusicUrl = URL(string: urlString)
        } else { self.appleMusicUrlString = nil; self.appleMusicUrl = nil }
        
        if let urlString = dict["spotifyUrl"] as? String {
            self.spotifyUrlString = urlString
            self.spotifyUrl = URL(string: urlString)
        } else { self.spotifyUrlString = nil; self.spotifyUrl = nil }
    }
    
}
