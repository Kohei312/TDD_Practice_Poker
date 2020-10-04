//
//  Hand.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation

struct Hand{
    
    #warning("ただし、手札が0,または1枚のときに必ずクラッシュする")
    var cards:[Card]
    
    var isEqualSuit: Bool{
        return cards[0].hasSameSuit(cards[1])
    }
    var isEqualRank: Bool{
        return cards[0].hasSameRank(cards[1])
    }
    var isContinuousRank: Bool{
        return cards[0].isContinuousRank(cards[1])
    }
}
