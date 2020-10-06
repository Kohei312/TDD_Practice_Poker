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

struct Hand{
    
    #warning("ただし、手札が0,または1枚のときに必ずクラッシュする")
    var cards:[Card]
    
    var hasEqualSuit:[ Card.Suit ]{
        checkAllEqualSuit()
    }
    var hasEqualRank:[ Card.Rank:HandState ]{
        checkEqualRanks()
    }
    var hasContinuousRank:[ [Card] ]{
        checkContinuious()
    }
}
