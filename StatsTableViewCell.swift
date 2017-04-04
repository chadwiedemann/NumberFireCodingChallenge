//
//  StatsTableViewCell.swift
//  NumberFireCodingChallenge
//
//  Created by Chad Wiedemann on 4/3/17.
//  Copyright © 2017 Chad Wiedemann LLC. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {

    @IBOutlet weak var nERDValueLabel: UILabel!
    @IBOutlet weak var ptsAstRebLabel: UILabel!
    @IBOutlet weak var playerTeamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
