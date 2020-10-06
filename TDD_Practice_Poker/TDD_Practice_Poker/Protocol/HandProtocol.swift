//
//  HandProtocol.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/04.
//

import Foundation

extension Hand:HandProtocol{
    
    func checkAllEqualSuit()->[Card.Suit]{
        
        var suit:[Card.Suit] = []
        
        let allSuits = Dictionary(grouping: cards.compactMap({$0.suit})){$0}
        if  allSuits.values.contains(where: {$0.count == 5}){
            suit = [allSuits.filter({$0.value.count == 5})[0].key]
        }
        return suit
    }
    
    func checkEqualRanks()->[ Card.Rank:HandState ]{
        
        var equalRankDics:[ Card.Rank:HandState ] = [:]
        
        let allRanks = Dictionary(grouping: cards.compactMap({$0.rank})){$0}
        allRanks.forEach({ rankDic in
            if rankDic.value.count == 2 {
                let key = rankDic.key
                if equalRankDics.isEmpty{
                    equalRankDics = [key:HandState.onePair]
                } else {
                    equalRankDics[key] = HandState.onePair
                }

            } else if rankDic.value.count == 3 {
                let key = rankDic.key
                if equalRankDics.isEmpty{
                    equalRankDics = [key:HandState.threeCard]
                } else {
                    equalRankDics[key] = HandState.threeCard
                }

            } else if rankDic.value.count == 4 {
                let key = rankDic.key
                equalRankDics = [key:HandState.fourCard]
            }
        })
        
        return equalRankDics
    }
    
    func checkContinuious()->[[Card]]{
        
        // 対象となるのは、hasEqualRankではない[Card]
        var continuousCards:[[Card] ] = []
        let willSortCards:[Card] = self.cards.sorted(by: {$0.rank < $1.rank})
        var count = 0
        
        for z in 0..<willSortCards.count{
            // MARK:- 比較する配列インデックス
            let y = z + 1
            
            if willSortCards.indices.contains(y){
                
                
                if  willSortCards[z].rank == .two || willSortCards[z].rank == .five{
                    
                    if  willSortCards.contains(where: {$0.rank == .ace}){
                        // Aceとtwoが共存する場合はOK
                        count += 1
                        if count == willSortCards.count-1{
                            continuousCards.append(willSortCards)
                        }
                        
                    } else {
                        
                        if willSortCards[z].isContinuousRank(willSortCards[y]){
                            count += 1
                            if count == willSortCards.count-1{
                                continuousCards.append(willSortCards)
                            }
                        }
                        
                    }
                    
                } else if willSortCards[z].isContinuousRank(willSortCards[y]){
                    // z番目とz+1番目が連続している場合もOK
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
