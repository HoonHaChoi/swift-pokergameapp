//
//  PokerGame.swift
//  PokerGameApp
//
//  Created by HOONHA CHOI on 2021/02/16.
//

import Foundation

enum GameType : Int {
    case seven = 7
    case five = 5
    
    var value : Int {
        return self.rawValue
    }
    static var allValues: [GameType] {
        return [.seven,.five]
    }
}

enum Participant : Int {
    case one = 1
    case two
    case three
    case four
    
    var value: Int {
        return self.rawValue
    }
    static var allValues: [Participant] {
        return [.one,.two,.three,.four]
    }
}

class PockerGame {
    private var players = Players()
    private var participant : Int = 0
    private var gameType : Int = 0
    
    func startGame() {
        players.addPlayer(particpatin: self.participant)
        players.drawCard(gameType: self.gameType)
    }
    
    func showPlayersCard() -> [PlayerCard] {
        return players.showPlayerCard()
    }
    
    func selectGameType(index : Int) {
        gameType = GameType.allValues[index].value
    }
    
    func selectParticipant(index : Int) {
        participant = Participant.allValues[index].value
    }
    
    func resetCard() {
        players.resetCard()
    }
    
    func countCardDeck() -> Bool {
        return players.countCardDeck(gameType : gameType)
    }
}

