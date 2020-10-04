//
//  Hand.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation

protocol HandProtocol{
    func checkEqual(type:CardType)->[[Card]]
    func checkContinuious()->[[Card]]
}

struct Hand{
    
    #warning("ただし、手札が0,または1枚のときに必ずクラッシュする")
    var cards:[Card]
    
    var hasEqualSuit:[ [Card] ]{
        checkEqual(type: CardType.Suit)
    }
    var hasEqualRank:[ [Card] ]{
        checkEqual(type: CardType.Rank)
    }
    var hasContinuousRank:[ [Card] ]{
        checkContinuious()
    }
}
