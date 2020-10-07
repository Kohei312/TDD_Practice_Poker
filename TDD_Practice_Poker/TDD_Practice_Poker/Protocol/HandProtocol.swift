//
//  HandProtocol.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/04.
//

import Foundation

extension Hand{
    
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
        // ここで昇順ソートしておく
        let willSortCards:[Card] = self.cards.sorted(by: {$0.rank < $1.rank})
        var count = 0
        
        for z in 0..<willSortCards.count{
            // MARK:- 比較する配列インデックス
            var y = z + 1
            
            if willSortCards.indices.contains(y){
                if willSortCards[z].isContinuousRank(willSortCards[y]){
                    count += 1
                    if count == willSortCards.count-1{
                        continuousCards.append(willSortCards)
                    }
                }
            } else {
                
                y = 0
                
                // 最後尾の判別
                // -> .aceか？
                // -> さらに、最前部が .twoなら連続していると判断
                if  willSortCards[z].rank == .ace && willSortCards[y].rank == .two{
                    
                    count += 1
                    if count == willSortCards.count-1{
                        continuousCards.append(willSortCards)
                    }
                }
            }
        }
        
        return continuousCards
    }
    
    // ストレートか否かを知りたい
    // -> 昇順ソートして、5つ全てが連続していることがわかればOK
    // -> 昇順ソートした[Card.Rank]が返ればOK
    func checkContinuiousRank()->[Card.Rank]{
        // 対象となるのは、hasEqualRankではない[Card]
        var continuousRanks:[ Card.Rank ] = []
        // ここで昇順ソートしておく
        let willSortCards:[Card] = self.cards.sorted(by: {$0.rank < $1.rank})
//        var count = 0
        
        for x in 0..<willSortCards.count{
            // MARK:- 比較する配列インデックス
            var y = x + 1
            
            if willSortCards.indices.contains(y){
                if willSortCards[x].isContinuousRank(willSortCards[y]){
                    continuousRanks.append(willSortCards[y].rank)
                                    
                    if !continuousRanks.contains(willSortCards[x].rank){
                        continuousRanks.append(willSortCards[x].rank)
                    }
                } else {
                    // すべて連続していない場合は [] を返す
                    return []
                }
            } else {
                
                y = 0
                
                // 最後尾の判別
                // -> .aceか？
                // -> さらに、最前部が .twoなら連続していると判断
                if  willSortCards[x].rank == .ace && willSortCards[y].rank == .two{
                    
                    continuousRanks.append(willSortCards[x].rank)
                                    
                    if !continuousRanks.contains(willSortCards[y].rank){
                        continuousRanks.append(willSortCards[y].rank)
                    }
                }
            }
        }
        
        return continuousRanks
    }
}
