//
//  Deck.swift
//  PokerGameApp
//
//  Created by HOONHA CHOI on 2021/02/17.
//

import Foundation

class Deck {
    private var handCard : [Card] = []
    
    func receiveCard(card : Card) {
        handCard.append(card)
    }
    
    func showCards(closure : (Card)->()) {
        handCard.forEach { (card) in
            closure(card)
        }
    }
    
    func resetCard() {
        handCard.removeAll()
    }
    
    func countCard() -> Int {
        return handCard.count
    }
    
    func emptyCard() -> Bool {
        return handCard.isEmpty
    }
    
    func score() -> Int {
        var cardScore : [Int:Int] = [:]
        handCard.forEach { (card) in
            cardScore[card.rank.value] = (cardScore[card.rank.value] ?? 0) + 1
        }
        guard let score = cardScore.values.max() else { return 0 }
        return score
    }
}
