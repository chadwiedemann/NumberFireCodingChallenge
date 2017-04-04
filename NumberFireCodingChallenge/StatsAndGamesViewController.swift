//
//  StatsAndGamesViewController.swift
//  NumberFireCodingChallenge
//
//  Created by Chad Wiedemann on 4/3/17.
//  Copyright © 2017 Chad Wiedemann LLC. All rights reserved.
//

import UIKit

class StatsAndGamesViewController: UIViewController {

    @IBOutlet weak var gamesButton: UIButton!
    @IBOutlet weak var statsButton: UIButton!
    @IBOutlet weak var gamesView: UIView!
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var gamesTableView: UITableView!
    @IBOutlet weak var statsTableView: UITableView!
    let dao = DAO.sharedInstance
    var gamesButtonSelected: Bool = true
    let blueColor = UIColor.init(red: 0, green: 0.478431, blue: 1, alpha: 1)
    let whiteColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gamesButton.layer.borderWidth = 1
        statsButton.layer.borderWidth = 1
        gamesButton.layer.masksToBounds = true
        statsButton.layer.masksToBounds = true
        gamesButton.backgroundColor = blueColor
        gamesButton.layer.borderColor = UIColor.init(red: 0, green: 0.478431, blue: 1, alpha: 1).cgColor
        statsButton.layer.borderColor = UIColor.init(red: 0, green: 0.478431, blue: 1, alpha: 1).cgColor
        gamesButton.setTitleColor(whiteColor, for: UIControlState.normal)
        dao.readJSONDataIntoDictionaty()
    }

    @IBAction func gameButtonPressed(_ sender: UIButton) {
        setButtonColors()
    }

    @IBAction func statsButtonPressed(_ sender: UIButton) {
        setButtonColors()
    }

    func setButtonColors() {
        if gamesButtonSelected == true {
            self.gamesView.isHidden =  true
            gamesButtonSelected = false
            gamesButton.setTitleColor(blueColor, for: UIControlState.normal)
            gamesButton.backgroundColor = whiteColor
            statsButton.setTitleColor(whiteColor, for: UIControlState.normal)
            statsButton.backgroundColor = blueColor
        }else{
            self.gamesView.isHidden = false
            gamesButtonSelected = true
            gamesButton.setTitleColor(whiteColor, for: UIControlState.normal)
            gamesButton.backgroundColor = blueColor
            statsButton.setTitleColor(blueColor, for: UIControlState.normal)
            statsButton.backgroundColor = whiteColor
        }
    }
}

extension StatsAndGamesViewController: UITableViewDelegate, UITableViewDataSource{
    
    //configures cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.gamesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "gameCellID", for: indexPath) as! GamesTableViewCell
            
            self.hideLabelsCorrectly(game: dao.allGameStates[indexPath.row], cell: cell)
            let teamNames = getTeamNames(index: indexPath.row)
            let teamScore = getTeamScores(index: indexPath.row)
            cell.homeTeamNameLabel.text = teamNames.0
            cell.awayTeamNameLabel.text = teamNames.1
            cell.homeTeamPointsLabel.text = "\(teamScore.0)"
            cell.awayTeamPointsLabel.text = "\(teamScore.1)"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "statsCellID", for: indexPath) as! StatsTableViewCell
            let currentPlayerID = dao.allPlayerStats[indexPath.row].player_id
            var playerName = ""
            var playerAbbrev = ""
            let currentnERD: Double = dao.allPlayerStats[indexPath.row].nerd
            let playerPTS: Int? = dao.allPlayerStats[indexPath.row].points
            let playerAst: Int? = dao.allPlayerStats[indexPath.row].assists
            let playerReb: Int? = dao.allPlayerStats[indexPath.row].rebounds
            dao.players.forEach({ currentPlayer in
                if currentPlayer.id == (currentPlayerID!) {
                    playerName = currentPlayer.name
                    playerAbbrev = teamAbbrevFrom(id: currentPlayer.team_id)
                }
            })
            cell.playerTeamLabel.text = "\(playerName) - \(playerAbbrev)"
            cell.nERDValueLabel.text = "\(currentnERD)"
            cell.ptsAstRebLabel.text = "\(String(describing: playerPTS!)) Pts, \(String(describing: playerAst!)) Ast, \(String(describing: playerReb!)) Reb"
            return cell
        }
    }
    
    //number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.gamesTableView {
            return dao.allGameStates.count
            
        }else{
            return dao.allPlayerStats.count
        }
    }
    
    //returns the team abbreviation from the team id
    func teamAbbrevFrom(id: Int) -> String {
        var teamAbbrev = ""
        dao.teams.forEach { (Team) in
            if id == Team.id{
                teamAbbrev = Team.abbrev
            }
        }
        return teamAbbrev
    }
    
    //returns the team names that are playing in the game
    func getTeamNames(index: Int) -> (String, String) {
        var homeTeamID: Int?
        var awayTeamID: Int?
        let gameID = dao.allGameStates[index].gameID
        dao.games.forEach { currentGame in
            if currentGame.id == gameID{
                homeTeamID = currentGame.homeTeamId
                awayTeamID = currentGame.awayTeamId
            }
        }
        var homeTeamName: String?
        var awayTeamName: String?
        
        dao.teams.forEach { currentTeam in
            if currentTeam.id == homeTeamID{
                homeTeamName = currentTeam.name
            }
            if currentTeam.id == awayTeamID{
                awayTeamName = currentTeam.name
            }
        }
        return (homeTeamName!, awayTeamName!)
    }
    
    //returns the team scores for the game in the current cell
    func getTeamScores(index: Int) -> (Int, Int) {
        var awayTeamScore: Int?
        var homeTeamScore: Int?
        dao.allGameStates.forEach { (GameState) in
            if GameState.id == (index + 1){
                awayTeamScore = GameState.awayTeamScore
                homeTeamScore = GameState.homeTeamScore
            }
        }
        return (homeTeamScore!, awayTeamScore!)
    }
    
    //hides or shows labels if the game is finished or not
    func hideLabelsCorrectly(game: GameState, cell: GamesTableViewCell) {
        if game.gameStatus == Constants.FINAL {
            cell.gameTimeLabel.isHidden = true
            cell.broadcasterLabel.isHidden = true
            cell.centerViewInCell.backgroundColor = UIColor.init(colorLiteralRed: 0/255, green: 255/255, blue: 102/255, alpha: 0.2)
        }else{
            cell.finalLabel.isHidden = true
            cell.broadcasterLabel.text = "\(game.broadcast!)"
            cell.gameTimeLabel.text = "Q\(game.quarter!) \(game.timeLeftInQuarter!)"
            cell.centerViewInCell.backgroundColor = UIColor.init(colorLiteralRed: 0/255, green: 255/255, blue: 102/255, alpha: 1)
        }
    }
}


