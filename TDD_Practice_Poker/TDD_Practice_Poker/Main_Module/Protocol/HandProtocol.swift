//
//  HandProtocol.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/04.
//

import Foundation

protocol CardManagementProtocol{
    func checkAllEqualSuit()->[Card.Suit]
    func checkEqualRanks()->[ Card.Rank:HandState ]
}

protocol HandStatementProtocol{
    func manageHandState() -> HandState
    func checkCardPairType(pairType:HandState) -> Bool
    func checkFlushStatus(_ cards:[Card.Rank]) -> HandState
    func checkStraightStatus(_ cards:[Card.Rank]) -> HandState
}

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
                    if continuousRanks.contains(willSortCards[x].rank){
                       let i = continuousRanks.filter({$0 == willSortCards[x].rank})[0]
                        if let removeIndex = continuousRanks.firstIndex(of: i){
                            continuousRanks.remove(at: removeIndex)
                        }
                    }
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


extension Hand{
    
    func manageHandState()->HandState{
        
        var state:HandState = .nothing
        
        if self.hasAllEqualSuit == [] &&
            self.hasEqualRank == [:] &&
            self.hasContinuousRank == []{
            
            state = .highCard
            
        } else {
            
            if self.hasAllEqualSuit != []{
                
                if self.hasContinuousRank == []{
                    
                    state = .flush
                    
                } else if self.hasContinuousRank.count == 5 {
                    
                    state = checkFlushStatus(self.hasContinuousRank)
                }
                
            } else if checkCardPairType(pairType: .onePair){
                
                if checkCardPairType(pairType: .threeCard){
                    
                    state = .fullHouse
                    
                } else {
                    
                    if self.hasEqualRank.filter({$0.value == .onePair}).count == 2{
                        
                        state = .twoPair
                        
                    } else {
                        
                        state = .onePair
                    }
                }
                
            } else if checkCardPairType(pairType: .threeCard){
                
                
                state = .threeCard
                
                
            } else if checkCardPairType(pairType: .fourCard){
                
                
                state = .fourCard
                
                
            }  else if self.hasContinuousRank.count == 5 {
                
                state = checkStraightStatus(self.hasContinuousRank)
                
            } else {
                
                state = .highCard
                
            }
            
            
        }
        return state
    }
    
    func checkCardPairType(pairType:HandState) -> Bool{
        return self.hasEqualRank.values.contains(where: {$0 == pairType})
    }
    
    func checkFlushStatus(_ cards:[Card.Rank])->HandState{
        
        var state:HandState = .flush
        
        if cards == [.two,.three,.four,.king,.ace]{
            
            state = .flush
            
        } else if cards == [.two,.three,.queen,.king,.ace]{
            
            state = .flush
            
        } else if cards == [.two,.jack,.queen,.king,.ace]{
            
            state = .flush
            
        } else if cards == [.ten,.jack,.queen,.king,.ace]{
            
            state = .royalFlush
            
        } else {
            
            state = .straightFlush
        }
        return state
    }
    
    func checkStraightStatus(_ cards:[Card.Rank])->HandState{
        
        var state:HandState = .highCard
        
        if cards == [.two,.three,.four,.king,.ace]{
            
            state = .highCard
            
        } else if cards == [.two,.three,.queen,.king,.ace] {
            
            state = .highCard
            
        }  else if cards == [.two,.jack,.queen,.king,.ace]{
            
            state = .highCard
            
        } else {
            
            state = .straight
            
        }
        
        return state
    }
}

