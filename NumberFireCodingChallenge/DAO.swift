//
//  DAO.swift
//  NumberFireCodingChallenge
//
//  Created by Chad Wiedemann on 4/3/17.
//  Copyright © 2017 Chad Wiedemann LLC. All rights reserved.
//

import UIKit

class DAO: NSObject {

    static let sharedInstance = DAO()
    var players: [Player] = []
    var teams: [Team] = []
    var games: [Game] = []
    var allPlayerStats: [PlayerStats] = []
    var allGameStates: [GameState] = []
    
    //read JSON data from file
    func readJSONDataIntoDictionaty() {
        if let path = Bundle.main.path(forResource: Constants.basketballData, ofType: Constants.json) {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    create(arrays: jsonResult)
                } catch {
                    print(error.localizedDescription)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //creates arrays with object create from JSON
    func create(arrays: NSDictionary) {
        if let players: [NSDictionary] = arrays[Constants.Players] as? [NSDictionary] {
            for player: NSDictionary in players {
                let newPlayer = Player.init(id: player.value(forKey: Constants.id) as! Int, name: player.value(forKey: Constants.name) as! String, teamID: player.value(forKey: Constants.team_id) as! Int)
                self.players.append(newPlayer)
            }
        }
        if let teams: [NSDictionary] = arrays[Constants.Teams] as? [NSDictionary] {
            for team: NSDictionary in teams {
                let newTeam = Team.init(id: team.value(forKey: Constants.id) as! Int, name: team.value(forKey: Constants.name) as! String, city: team.value(forKey: Constants.city) as! String, fullName: team.value(forKey: Constants.full_name) as! String, abbrev: team.value(forKey: Constants.abbrev) as! String)
                self.teams.append(newTeam)
            }
        }
        if let games: [NSDictionary] = arrays[Constants.Games] as? [NSDictionary] {
            for game: NSDictionary in games {
                let newGame = Game.init(id: game.value(forKey: Constants.id) as! Int , homeTeamId: game.value(forKey: Constants.home_team_id) as! Int, awayTeamId: game.value(forKey: Constants.away_team_id) as! Int, date: game.value(forKey: Constants.date) as! String)
                self.games.append(newGame)
            }
        }
        if let playerStatsDic = arrays[Constants.Player_Stats] as? [NSDictionary]{
            for playerStats: NSDictionary in playerStatsDic {
                let newPlayerStats = PlayerStats.init(id: playerStats.value(forKey: Constants.id) as! Int, game_id: playerStats.value(forKey: Constants.game_id) as! Int, player_id: playerStats.value(forKey: Constants.player_id) as! Int, team_id: playerStats.value(forKey: Constants.team_id) as! Int, points: playerStats.value(forKey: Constants.points) as! Int, assists: playerStats.value(forKey: Constants.assists) as! Int, rebounds: playerStats.value(forKey: Constants.rebounds) as! Int, nerd: playerStats.value(forKey: Constants.nerd) as! Double)
                self.allPlayerStats.append(newPlayerStats)
            }
        }
        if let gameStateDic = arrays[Constants.Game_State] as? [NSDictionary]{
            for gameState: NSDictionary in gameStateDic {
                let newGameState = GameState.init(id: gameState.value(forKey: Constants.id) as! Int, gameID: gameState.value(forKey: Constants.game_id) as! Int, homeTeamScore: gameState.value(forKey: Constants.home_team_score) as! Int, awayTeamScore: gameState.value(forKey: Constants.away_team_score) as! Int, broadcast: gameState.value(forKey: Constants.broadcast) as! String, quarter: gameState.value(forKey: Constants.quarter) as! Int, timeLeftInQuarter: gameState.value(forKey: Constants.time_left_in_quarter) as! String, gameStatus: gameState.value(forKey: Constants.game_status) as! String)
                self.allGameStates.append(newGameState)
            }
        }
        self.allGameStates = self.allGameStates.reversed()
    }
}
