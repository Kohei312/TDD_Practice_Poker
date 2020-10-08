//
//  HandStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation

// MARK:- 手札の役の状態を監視する
enum HandState:Comparable{
    case nothing
    case highCard
    case onePair
    case twoPair
    case threeCard
    case straight
    case flush
    case fullHouse
    case fourCard
    case straightFlush
    case royalFlush
}

protocol HandOutputProtocol{
    mutating func willAddAppearedCards(_ cards:[Card])
}

// MARK:- PokerInteractorへOutputするProtocolをDIする
// MARK:- 役割は、各プレイヤーの手札を一元管理すること
struct HandStatus:HandOutputProtocol{
    // カードにsuit・rankとも同じカードがないように初期化したい
    // TODO:
    //  - まず初期化時は、分配する10枚のCardインスタンスをランダムに作成する(引数はPlayerTypeのみ)
    //  - PlayerごとのHandインスタンスに[Card]を入れる
    var myPlayerHand:Hand
    var otherPlayerHand:Hand
        
    
    init(myCards:[Card],otherCards:[Card]){
//        let myCards = Array(cardDeck.getCards(5))
//        let otherCards = Array(cardDeck.getCards(5))
        
        self.myPlayerHand = Hand(.me,cards:myCards)
        self.otherPlayerHand = Hand(.other,cards:otherCards)
    }
    
    
    func drawCard(_ takeNumber:Int)->[Card]{
        
        var cards:[Card] = []
        
        for i in 0...takeNumber{
            if cards.contains(makeCardInstance()) ||
                appearedCards.contains(makeCardInstance()){
                    
            }
            
        }
        return cards
    }
    
    func makeCardInstance()->Card{
        let suit = Card.Suit.allCases.randomElement()!
        let rank = Card.Rank.allCases.randomElement()!
        return Card(suit: suit, rank: rank)
    }
    
//    // ハッシュ値をつかって更新する
//    func changeCard(_ index:Int){
//        cards[index] = drawCard()
//        print("card[index] :",cards[index])
//    }
    
    
    mutating func willAddAppearedCards(_ cards: [Card]) {
        for card in cards {
            appearedCards.append(card)
        }
    }
}


