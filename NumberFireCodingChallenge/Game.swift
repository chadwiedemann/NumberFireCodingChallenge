//
//  Game.swift
//  NumberFireCodingChallenge
//
//  Created by Chad Wiedemann on 4/3/17.
//  Copyright © 2017 Chad Wiedemann LLC. All rights reserved.
//

import UIKit

class Game: NSObject {
    
    var id: Int!
    var homeTeamId: Int!
    var awayTeamId: Int!
    var date: String!
    
    init(id: Int, homeTeamId: Int, awayTeamId: Int, date: String) {
        self.id = id
        self.homeTeamId = homeTeamId
        self.awayTeamId = awayTeamId
        self.date = date
    }
}
