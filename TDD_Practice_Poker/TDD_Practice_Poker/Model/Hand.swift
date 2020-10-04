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
    
    var hasEqualSuit:[ [Card] ]{
               
        var suitCards:[ [Card] ] = []
        
        for j in 0 ..< cards.count{
            for i in j+1..<cards.count{
                let suitPair = cards[j].hasSameSuit(cards[i])
                if suitPair != []{
                    suitCards.append(suitPair)
                }
            }
        }
        
        return suitCards
    }
    var isEqualRank: Bool{
        return cards[0].hasSameRank(cards[1])
    }
    var isContinuousRank: Bool{
        return cards[0].isContinuousRank(cards[1])
    }
}
