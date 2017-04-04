//
//  Team.swift
//  NumberFireCodingChallenge
//
//  Created by Chad Wiedemann on 4/3/17.
//  Copyright © 2017 Chad Wiedemann LLC. All rights reserved.
//

import UIKit

class Team: NSObject {
    
    var id: Int!
    var name: String!
    var city: String!
    var full_name: String!
    var abbrev: String!
    
    init(id: Int, name: String, city: String, fullName: String, abbrev: String) {
        self.id = id
        self.name = name
        self.city = city
        self.full_name = fullName
        self.abbrev = abbrev
    }
}
