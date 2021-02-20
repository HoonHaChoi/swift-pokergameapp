//
//  Rule.swift
//  PokerGameApp
//
//  Created by HOONHA CHOI on 2021/02/20.
//

import Foundation

struct Rule {
    
    func cardScore(playerCard : PlayerCard) -> Int {
        return playerCard.cards.score()
    }
}
