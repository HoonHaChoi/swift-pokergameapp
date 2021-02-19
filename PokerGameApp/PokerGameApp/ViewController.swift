//
//  ViewController.swift
//  PokerGameApp
//
//  Created by HOONHA CHOI on 2021/02/15.
//

import UIKit

class ViewController: UIViewController {
    
    private let pockerGameStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let segmentStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let gameTypeSegmentControl : UISegmentedControl = {
        let segment = UISegmentedControl(items: GameType.gameTypeItem)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(actionGameTypeSegment(_:)) , for: .valueChanged)
        return segment
    }()
    
    private let particpatinSegmentControl : UISegmentedControl = {
        let segment = UISegmentedControl(items: Participant.participantItem)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(actionparticpatinSegment(_:)), for: .valueChanged)
        return segment
    }()
    
    @objc func actionGameTypeSegment(_ sender : UISegmentedControl) {
        gameType = GameType.allValues[sender.selectedSegmentIndex].value
        resetPokerGame()
    }
    @objc func actionparticpatinSegment(_ sender : UISegmentedControl) {
        participant = Participant.allValues[sender.selectedSegmentIndex].value
        resetPokerGame()
    }
    
    private var gameType : Int = GameType.seven.value
    private var participant : Int = Participant.one.value
    private let pokerGame = PockerGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundViewImage()
        setSegmentStackView()
        setPockerGameStackView()
        startPokerGame()
    }
    
    private func startPokerGame() {
        pokerGame.setGame(gameType: gameType, participant: participant)
        pokerGame.startGame()
        pokerGame.drawCard()
        setPlayerStackView()
    }
    
    private func resetPokerGame() {
        removePokerGameStackSubViews()
        pokerGame.resetPlayer()
        startPokerGame()
    }
    
    private func setBackgroundViewImage() {
        let backgroundimage = UIImage(named: "bg_pattern") ?? UIImage()
        self.view.backgroundColor = UIColor(patternImage: backgroundimage)
    }
    
    private func setSegmentStackView() {
        self.view.addSubview(segmentStackView)
        NSLayoutConstraint.activate([
            segmentStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 10),
            segmentStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        segmentStackView.addArrangedSubview(gameTypeSegmentControl)
        segmentStackView.addArrangedSubview(particpatinSegmentControl)
    }
    
    private func setPockerGameStackView() {
        self.view.addSubview(pockerGameStackView)
        NSLayoutConstraint.activate([
            pockerGameStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            pockerGameStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            pockerGameStackView.topAnchor.constraint(equalTo: segmentStackView.bottomAnchor, constant: 20)
        ])
    }
    
    private func setPlayerStackView() {
        pokerGame.showPlayersCard { (PlayerCard) in
            let playerStackView = UIStackView()
            playerStackView.axis = .vertical
            playerStackView.distribution = .fill
            playerStackView.alignment = .fill
            pockerGameStackView.addArrangedSubview(playerStackView)
            
            playerStackView.addArrangedSubview(makePlayerNameLabel(name: PlayerCard.name))
            playerStackView.addArrangedSubview(makeCard(cards: PlayerCard.cards.showCards()))
        }
    }
    
    private func makePlayerNameLabel(name : String) -> UILabel {
        let playerName = UILabel()
        playerName.textColor = .white
        playerName.text = name
        playerName.font = .boldSystemFont(ofSize: 20)
        playerName.translatesAutoresizingMaskIntoConstraints = false
        return playerName
    }
    
    private func makeCard(cards : [Card]) -> UIStackView {
        let cardStackView = UIStackView()
        cardStackView.axis = .horizontal
        cardStackView.distribution = .fillEqually
        cardStackView.alignment = .fill
        cardStackView.spacing = -10
        cardStackView.translatesAutoresizingMaskIntoConstraints = false
        
        cards.forEach { card in
            cardStackView.addArrangedSubview(createImageView(card : card))
        }
        return cardStackView
    }
	
    private func createImageView(card : Card) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: card.imgName)
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0/1.27).isActive = true
        return imageView
    }

    private func removePokerGameStackSubViews() {
        pockerGameStackView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake && pokerGame.countCardDeck() {
            removePokerGameStackSubViews()
            pokerGame.resetCard()
            pokerGame.drawCard()
            setPlayerStackView()
        }
    }
}

