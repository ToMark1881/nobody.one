//
//  ConcertsAPIService.swift
//  nobodyOne
//
//  Created by Vladyslav Vdovychenko on 07.07.2020.
//  Copyright © 2020 Vladyslav Vdovychenko. All rights reserved.
//

import Foundation
import Firebase

protocol ConcertsAPIInterface {
    func getConcerts(completed: @escaping(([Tour]) -> Void), failure: @escaping((Error?) -> Void))
}


class ConcertsAPIService: ConcertsAPIInterface {
    
    func getConcerts(completed: @escaping(([Tour]) -> Void), failure: @escaping((Error?) -> Void)) {
        Database.database().reference().child("tours").observeSingleEvent(of: .value) { (snap) in
            if let tours = snap.value as? [Dictionary<String, AnyObject>] {
                self.parseConcerts(dictionary: tours, completed: completed)
            }
        }
    }
    
    fileprivate func parseConcerts(dictionary: [Dictionary<String, AnyObject>],
                                   completed: @escaping(([Tour]) -> Void)) {
        var tours = [Tour]()
        for event in dictionary {
            let tour = Tour(event)
            tours.append(tour)
        }
        completed(tours)
    }
}
