//
//  Dealer.swift
//  PokerGameApp
//
//  Created by HOONHA CHOI on 2021/02/16.
//

import Foundation

class Dealer : Playable {
    private var cardDeck = CardDeck()
    private var deck = Deck()
    private let name = "딜러"
    private var cardScore: Int = 0
    
    init() {
        cardDeck.shuffle()
    }
    
    func receiveCard(card: Card) {
        deck.receiveCard(card: card)
    }
    
    func resetCards() {
        deck.resetCard()
    }
    
    func shareCard(player : Playable) {
        guard let card = cardDeck.removeOne() else { return }
        player.receiveCard(card: card)
    }
    
    func showCards(closure: (PlayerCard) -> Void) {
        let playerCard = PlayerCard(name: "\(name)", card: deck)
        closure(playerCard)
    }
    
    func resetPlayerCard(player : Playable) {
        player.resetCards()
    }
    
    func count(gameType : Int ,players : Int) -> Bool {
        return cardDeck.count() > gameType * players
    }
    
    func redrawCardDeck() {
        cardDeck.reset()
        cardDeck.shuffle()
    }
    
    func score(result : Int) {
        cardScore = result
    }
}
