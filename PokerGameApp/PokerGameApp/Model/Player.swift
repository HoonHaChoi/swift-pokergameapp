//
//  Player.swift
//  PokerGameApp
//
//  Created by HOONHA CHOI on 2021/02/16.
//

import Foundation

class Player : Playable {
    private var deck = Deck()
    private let name = "참가자"
    private let entryNumber : Int
    private var cardScore = 0
    
    init(entryNumber : Int) {
        self.entryNumber = entryNumber
    }
    
    func receiveCard(card : Card) {
        deck.receiveCard(card: card)
    }
    
    func showCards(closure: (PlayerCard) -> Void) {
        let playerCard = PlayerCard(name: "\(name)\(entryNumber)", card: deck)
        closure(playerCard)
    }
    
    func resetCards() {
        deck.resetCard()
    }
    
    func score(result : Int) {
        cardScore = result
    }
}
