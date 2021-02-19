//
//  Players.swift
//  PokerGameApp
//
//  Created by HOONHA CHOI on 2021/02/17.
//

import Foundation


class Players {
    private var players = [Playable]()
    private let dealer = Dealer()
    
    func addPlayer(particpatin : Int) {
        (1...particpatin).forEach { number in
            players.append(Player(entryNumber: number))
        }
        players.append(dealer)
    }
    
    func drawCard(gameType : Int) {
        players.forEach { player in
            (1...gameType).forEach { _ in
                dealer.shareCard(player : player)
            }
        }
    }
    
    func resetCard() {
        players.forEach { player in
            dealer.resetPlayerCard(player : player)
        }
    }
    
    func showPlayerCard(closure : (PlayerCard) -> ()) {
        players.forEach { player in
            player.showCards { (playcard) in
                closure(playcard)
            }
        }
    }
    
    func countCardDeck(gameType : Int) -> Bool {
        return dealer.count(gameType : gameType ,players : numberOfPlayer())
    }
    
    private func numberOfPlayer() -> Int {
        return players.count
    }
    
    func resetPlayer() {
        players.forEach { (player) in
            dealer.resetPlayerCard(player: player)
        }
        players.removeAll()
        dealer.redrawCardDeck()
    }
}
