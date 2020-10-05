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
                                
                                // i: [Card]の要素と、
                                // k: [Card]の要素をそれぞれ比較し
                                // 同じものがあるかどうかを比較したい => OK
                                if i.intersection(k) != []{
                                    let t = Array(i.union(k))
                                    print("まとめると　:",t)
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
        let willSortCards:[Card] = self.cards.sorted(by: {$0.rank < $1.rank})
//        var checkedCards:[Card] = []
        var count = 0
        
        for z in 0..<willSortCards.count{
            // MARK:- 比較する配列インデックス
            let y = z + 1
            
            if willSortCards.indices.contains(y){
                if willSortCards[z].isContinuousRank(willSortCards[y]){
                    count += 1
                    if count == willSortCards.count-1{
                        continuousCards.append(willSortCards)
                    }
                }
            }
        }
        return continuousCards
    }
}
