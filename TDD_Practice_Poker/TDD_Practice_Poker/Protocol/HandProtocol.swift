//
//  HandProtocol.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/04.
//

import Foundation

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
                                
                                if i == k {
                                    let t = Array(i.union(k))
                                    pairCards = [t]

                                }
                            }
                        }
                    }
                    
                }
            }
        }
        return pairCards
    }
    
    func checkContinuious()->[[Card]]{
        
        // 対象となるのは、hasEqualRankではない[Card]
        var continuousCards:[[Card] ] = []
        var willSortCards:[Card] = self.cards
        var checkedCards:[Card] = []
        
        hasEqualRank.forEach{(equalRanks) in
            let removeCards = equalRanks
            for removeCard in removeCards {
                willSortCards = self.cards.filter({$0 != removeCard})
            }
        }

        // 全カードのチェック
        for j in 0 ..< willSortCards.count{
            
            // 軸はcheckCards[j]
            let comparedCards = willSortCards.filter({$0 != willSortCards[j]})
            
            for i in j..<comparedCards.count{
                
                if willSortCards[j].isContinuousRank(comparedCards[i]){
                    // trueなら残す
                    checkedCards.append(willSortCards[j])
                    checkedCards.append(comparedCards[i])
                    continuousCards.append(checkedCards)
                    if continuousCards.count >= 2{
                        for r in 1..<continuousCards.count{
                            if continuousCards.indices.contains(r){
                                let i:Set<Card> = Set(continuousCards[r])
                                let k:Set<Card> = Set(continuousCards[r-1])
                                
                                let t = Array(i.union(k)).sorted(by: {$0.rank < $1.rank})
                                continuousCards = [t]
                            }
                        }
                    }
                }
            }
        }
        return continuousCards
    }
}
