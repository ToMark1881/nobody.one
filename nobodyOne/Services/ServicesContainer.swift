//
//  ServicesContainer.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import Foundation


class ServicesContainer {
    
    var concertService: ConcertsAPIInterface?
    var albumsSerive: AlbumsAPIInterface?
    
    init() {
        self.concertService = ConcertsAPIService()
        self.albumsSerive = AlbumsAPIService()
    }
    
}
