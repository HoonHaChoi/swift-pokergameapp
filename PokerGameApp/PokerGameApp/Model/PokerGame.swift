//
//  PokerGame.swift
//  PokerGameApp
//
//  Created by HOONHA CHOI on 2021/02/16.
//

import Foundation

enum GameType : Int, CaseIterable, CustomStringConvertible {
    case seven = 7
    case five = 5
    
    var description: String {
        return "\(self.rawValue) card"
    }
    
    var value : Int {
        return self.rawValue
    }
    static var allValues: [GameType] {
        return [.seven,.five]
    }
    
    static var gameTypeItem : [String] {
        var item = [String]()
        GameType.allCases.forEach{ item.append($0.description) }
        return item
    }
    
}

enum Participant : Int, CaseIterable, CustomStringConvertible {
    case one = 1
    case two
    case three
    case four
    
    var description: String {
        return "\(self.rawValue) 명"
    }
    
    var value: Int {
        return self.rawValue
    }
    static var allValues: [Participant] {
        return [.one,.two,.three,.four]
    }
    
    static var participantItem : [String] {
        var item = [String]()
        Participant.allCases.forEach { item.append($0.description) }
        return item
    }
}

class PockerGame {
    private var players = Players()
    private var participant : Int
    private var gameType : Int
    
    init(){
        self.gameType = 0
        self.participant = 0
    }
    
    func startGame() {
        players.addPlayer(particpatin: self.participant)
    }
    
    func drawCard() {
        players.drawCard(gameType: self.gameType)
    }
    
    func setGame(gameType : Int, participant : Int) {
        self.gameType = gameType
        self.participant = participant
    }
    
    func resetPlayer() {
        players.resetPlayer()
    }
    
    func showPlayersCard(closure : ((PlayerCard) -> ())) {
        players.showPlayerCard { (PlayerCard) in
            closure(PlayerCard)
        }
    }
    
    func resetCard() {
        players.resetCard()
    }
    
    func countCardDeck() -> Bool {
        return players.countCardDeck(gameType : gameType)
    }
    
    func gamescore() {
        players.winner()
    }
}

