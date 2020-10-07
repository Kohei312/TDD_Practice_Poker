//
//  Hand.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation

protocol HandProtocol{
    func checkAllEqualSuit()->[Card.Suit]
    func checkEqualRanks()->[ Card.Rank:HandState ]
    func checkContinuious()->[[Card]]
}

struct Hand:HandProtocol{
    
    #warning("ただし、手札が0,または1枚のときに必ずクラッシュする")
    var cards:[Card]
    
// カードにsuit・rankとも同じカードがないように初期化したい
//    init(){
//        cards = (1..<5).enumerated().map {_ in
//            let suit = Card.Suit.allCases.randomElement()!
//            let rank = Card.Rank.allCases.randomElement()!
//
//            return Card(suit: suit, rank: rank)
//        }
//    }
    
    var hasAllEqualSuit:[ Card.Suit ]{
        checkAllEqualSuit()
    }
    var hasEqualRank:[ Card.Rank:HandState ]{
        checkEqualRanks()
    }
    var hasContinuousRank:[ Card.Rank ]{
        checkContinuiousRank()
    }
    
}
