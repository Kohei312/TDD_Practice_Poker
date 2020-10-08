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
    var hand:Hand
    var appearedCards:[Card] = []
    
    
    init(_ playerType:PlayerType){
        self.hand = Hand(playerType)
    }
    
    
    mutating func willAddAppearedCards(_ cards: [Card]) {
        for card in cards {
            appearedCards.append(card)
        }
    }
    
}


