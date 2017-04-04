//
//  GameState.swift
//  NumberFireCodingChallenge
//
//  Created by Chad Wiedemann on 4/3/17.
//  Copyright © 2017 Chad Wiedemann LLC. All rights reserved.
//

import UIKit

class GameState: NSObject {
    
    var id: Int!
    var gameID: Int!
    var homeTeamScore: Int!
    var awayTeamScore: Int!
    var broadcast: String!
    var quarter:  Int!
    var timeLeftInQuarter: String!
    var gameStatus: String!
    
    init(id: Int, gameID: Int, homeTeamScore: Int, awayTeamScore: Int, broadcast: String, quarter: Int, timeLeftInQuarter: String, gameStatus: String) {
        self.id = id
        self.gameID = gameID
        self.homeTeamScore = homeTeamScore
        self.awayTeamScore = awayTeamScore
        self.broadcast = broadcast
        self.quarter = quarter
        self.timeLeftInQuarter = timeLeftInQuarter
        self.gameStatus = gameStatus
    }
}
