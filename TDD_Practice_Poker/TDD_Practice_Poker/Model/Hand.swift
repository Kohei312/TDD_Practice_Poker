//
//  Hand.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation

protocol HandProtocol{
    func checkEqual(type:CardType)->[[Card]]
}

extension Hand:HandProtocol{
    func checkEqual(type:CardType)->[[Card]]{
        var pairCards:[[Card]] = []

        for j in 0 ..< cards.count{
            let comparedCards = cards.filter({$0 != cards[j]})

            for i in j..<comparedCards.count{
                var pair:[Card] = []
                switch type{
                
                case .Suit:
                    pair = cards[j].hasSameSuit(comparedCards[i])
                    break
                case .Rank:
                    pair = cards[j].hasSameRank(comparedCards[i])
                    break
                }
               
                if pair != []{
                    pairCards.append(pair)
                    if pairCards.count >= 2{
                        for r in 1..<pairCards.count{
                            if pairCards.indices.contains(r){
                                let i:Set<Card> = Set(pairCards[r])
                                let k:Set<Card> = Set(pairCards[r-1])
                                
                                let t = Array(i.union(k))
                                pairCards = [t]
                            }
                        }
                    }
                    
                }
            }
        }
        return pairCards
    }
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
    var isContinuousRank: Bool{
        return cards[0].isContinuousRank(cards[1])
    }
}
