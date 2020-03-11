//
//  Players.swift
//  CardGameApp
//
//  Created by Keunna Lee on 2020/02/18.
//  Copyright © 2020 Keunna Lee. All rights reserved.
//

import Foundation

class Participants {
    private var allParticipants = [PokerPlayer]()
    
    init(with numbersOfPlayers : NumbersOfPlayers,and dealer: Dealer){
        var playerNumber = 1
        numbersOfPlayers.setPlayerSeat {
            self.allParticipants.append(PokerPlayer())
            allParticipants.last?.decideName(with: "Player\(playerNumber)")
            playerNumber += 1
        }
        self.allParticipants.append(dealer)
        allParticipants.last?.decideName(with: "Dealer")
    }

    func addCards(newCard: Card) {
        allParticipants.forEach{
            dealer in dealer.addOneCard(newCard: newCard)
        }
    }
    
    func forEachParticipant(behavior: (PokerPlayer) -> ()) {
        allParticipants.forEach { participant in
            behavior(participant)
        }
    }
    
    func findCombination(){
        allParticipants.forEach{ participant in
        participant.findMyCombination()
        }
    }
    
    func updateEachScore(addScore: (_ pokerPlayer: PokerPlayer,_ with: Int) -> ()){
        allParticipants.forEach{ participant in
            participant.showEachMyCombination(behavior: ){ combination in
                let score = combination.tellScore()
                addScore(participant, score)
            }
        }
    }

    func giveExtraScoreForHigherRank(addScore: (_ to: PokerPlayer,_ with: Int) -> ()){
        allParticipants.forEach{ participant in
            var comparingRank = 0
            participant.showHighestRank(behavior: ){
                cardRank in
                
                if comparingRank <= cardRank {
                    comparingRank = cardRank
                }else{
                    // 더 높은 사람에게 추가점수
                    addScore(participant, 1)
                }
            }
        }
    }
}
