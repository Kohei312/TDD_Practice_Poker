//
//  Hand.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation

extension Hand{
    func checkEqualSuit()->[[Card]]{
        var suitCards:[[Card]] = []

        for j in 0 ..< cards.count{
            let comparedCards = cards.filter({$0 != cards[j]})

            for i in j..<comparedCards.count{
                let suitPair = cards[j].hasSameSuit(comparedCards[i])
                if suitPair != []{
                    suitCards.append(suitPair)
                    
                    if suitCards.count >= 2{
                        for r in 1..<suitCards.count{
                            if suitCards.indices.contains(r){
                                let i:Set<Card> = Set(suitCards[r])
                                let k:Set<Card> = Set(suitCards[r-1])
                                
                                let t = Array(i.union(k))
                                suitCards = [t]
                            }
                        }
                    }
                    
                }
            }
        }
        return suitCards
    }
    
    func checkEqualRank()->[[Card]]{
        var suitCards:[[Card]] = []

        
        for j in 0 ..< cards.count{
            let comparedCards = cards.filter({$0 != cards[j]})

            for i in j..<comparedCards.count{
                #warning("違うのはここだけ")
                let suitPair = cards[j].hasSameRank(comparedCards[i])
                if suitPair != []{
                    suitCards.append(suitPair)
                    
                    if suitCards.count >= 2{
                        for r in 1..<suitCards.count{
                            if suitCards.indices.contains(r){
                                let i:Set<Card> = Set(suitCards[r])
                                let k:Set<Card> = Set(suitCards[r-1])
                                
                                let t = Array(i.union(k))
                                suitCards = [t]
                            }
                        }
                    }
                    
                }
            }
        }
        return suitCards
    }
}

struct Hand{
    
    #warning("ただし、手札が0,または1枚のときに必ずクラッシュする")
    var cards:[Card]
    
    var hasEqualSuit:[ [Card] ]{
        checkEqualSuit()
    }
    var hasEqualRank:[ [Card] ]{
        checkEqualRank()
    }
//    var isEqualRank: Bool{
//        return cards[0].hasSameRank(cards[1])
//    }
    var isContinuousRank: Bool{
        return cards[0].isContinuousRank(cards[1])
    }
}
