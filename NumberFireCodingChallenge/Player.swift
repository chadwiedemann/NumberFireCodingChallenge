//
//  Player.swift
//  NumberFireCodingChallenge
//
//  Created by Chad Wiedemann on 4/3/17.
//  Copyright © 2017 Chad Wiedemann LLC. All rights reserved.
//

import UIKit

class Player: NSObject {
    
    var id: Int!
    var name: String!
    var team_id: Int!
    
    init(id: Int, name: String, teamID: Int) {
        self.id = id
        self.name = name
        self.team_id = teamID
    }
}
