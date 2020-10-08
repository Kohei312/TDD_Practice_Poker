//
//  Hand.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation
// Playerと状態を共有するため、ここはclass化
// -> PlayerStatusでPlayerインスタンスを一元管理. 場に出たカード管理も移譲する
struct Hand:CardManagementProtocol,HandStatementProtocol{
    
    #warning("ただし、手札が0,または1枚のときに必ずクラッシュする")
    var playerType:PlayerType
    var cards:[Card]
    // スタブ 用
//    init(_ cards:[Card]){
          // MARK:- HandStatusで[Card]を作成して渡すこと
//        self.cards = cards
//    }

        init(_ playerType:PlayerType){
            self.playerType = playerType
            self.cards = CardStub().cards
            //        cards = (1..<5).enumerated().map {_ in
            //            drawCard()
            //        }
        }
    var hasAllEqualSuit:[ Card.Suit ]{
        checkAllEqualSuit()
    }
    var hasEqualRank:[ Card.Rank:HandState ]{
        checkEqualRanks()
    }
    var hasContinuousRank:[ Card.Rank ]{
        checkContinuiousRank()
    }
    
    var handState:HandState{
        manageHandState()
    }
    
    // カードプロパティは、ここで取得する
    func getCards()->[Card]{
        return cards
    }
    
    func drawCard()->Card{
        let suit = Card.Suit.allCases.randomElement()!
        let rank = Card.Rank.allCases.randomElement()!
        
        return Card(suit: suit, rank: rank)
    }
    
    // ハッシュ値をつかって更新する
    func changeCard(_ index:Int){
        cards[index] = drawCard()
        print("card[index] :",cards[index])
    }
    
}
