//
//  PlayerStats.swift
//  NumberFireCodingChallenge
//
//  Created by Chad Wiedemann on 4/3/17.
//  Copyright © 2017 Chad Wiedemann LLC. All rights reserved.
//

import UIKit

class PlayerStats: NSObject {
    
    var id: Int!
    var game_id: Int!
    var player_id: Int!
    var team_id: Int!
    var points: Int!
    var assists: Int!
    var rebounds: Int!
    var nerd: Double!
    
    init(id: Int, game_id: Int, player_id: Int, team_id: Int, points: Int, assists: Int, rebounds: Int, nerd: Double) {
        self.id = id
        self.game_id = game_id
        self.player_id = player_id
        self.team_id = team_id
        self.points = points
        self.assists = assists
        self.rebounds = rebounds
        self.nerd = nerd
    }
}
