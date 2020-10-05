//
//  HandStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation

enum HandState:Comparable{
    case nothing
    case highCard
    case onePair
    case twoPair
    case threeCard
    case straight
    case flush
    case fullHouse
    case fourCard
    case straightFlush
    case royalFlush
}

struct HandStatus{
    
    var hand:Hand
    var handState:HandState{
        var state:HandState = .nothing
        
        if hand.hasEqualSuit == [] &&
            hand.hasEqualRank == [] &&
            hand.hasContinuousRank == []{
            
            state = .highCard
            
        } else {
            
            if hand.hasEqualRank.contains(where: {$0.count == 2}){
                
                if hand.hasEqualRank.count == 1 && hand.hasEqualRank.filter({$0.count == 2}).count == 1{
                    state = .onePair
                } else if hand.hasEqualRank.count == 2 && hand.hasEqualRank.filter({$0.count == 2}).count == 2{
                    // twoPair => OK
                    state = .twoPair
                } else if hand.hasEqualRank.count == 2 && hand.hasEqualRank.filter({$0.count == 3}).count == 1{
                    
                    state = .fullHouse
                }
                
            } else if hand.hasEqualRank.contains(where: {$0.count == 3}){
                
                
                state = .threeCard
                
                
            } else if hand.hasEqualSuit.contains(where: {$0.count == 5}){
                                
                if hand.hasContinuousRank.contains(where: {$0.count == 5}){
                    
                    let i = hand.hasContinuousRank.compactMap({$0.compactMap({$0.rank })})
                    for j in i {
                        
                        if j.contains(where: {$0 == .four}) && j.contains(where: {$0 == .three}) && j.contains(where: {$0 == .two}) && j.contains(where: {$0 == .ace}) && j.contains(where: {$0 == .king}){
                            
                            state = .flush
                            
                        } else if j.contains(where: {$0 == .three}) && j.contains(where: {$0 == .two}) && j.contains(where: {$0 == .ace}) && j.contains(where: {$0 == .king}) && j.contains(where: {$0 == .queen}){
                            
                            state = .flush
                            
                        } else if j.contains(where: {$0 == .two}) && j.contains(where: {$0 == .ace}) && j.contains(where: {$0 == .king}) && j.contains(where: {$0 == .queen}) && j.contains(where: {$0 == .jack}){
                            
                            state = .flush
                            
                        } else if j.contains(where: {$0 == .ace}) && j.contains(where: {$0 == .king}) && j.contains(where: {$0 == .queen}) && j.contains(where: {$0 == .jack}) && j.contains(where: {$0 == .ten}){
                            
                            state = .royalFlush
                            
                        } else {
                            
                            state = .straightFlush
                        
                        }
                    }
                }

                
            } else if hand.hasContinuousRank.contains(where: {$0.count == 5}) {
                
                let i = hand.hasContinuousRank.compactMap({$0.compactMap({$0.rank })})
                for j in i {
                    if j.contains(where: {$0 == .four}) && j.contains(where: {$0 == .three}) && j.contains(where: {$0 == .two}) && j.contains(where: {$0 == .ace}) && j.contains(where: {$0 == .king}){
                        
                        state = .highCard
                        
                    } else if j.contains(where: {$0 == .three}) && j.contains(where: {$0 == .two}) && j.contains(where: {$0 == .ace}) && j.contains(where: {$0 == .king}) && j.contains(where: {$0 == .queen}){
                        
                        state = .highCard
                        
                    } else if j.contains(where: {$0 == .two}) && j.contains(where: {$0 == .ace}) && j.contains(where: {$0 == .king}) && j.contains(where: {$0 == .queen}) && j.contains(where: {$0 == .jack}){
                        
                        state = .highCard
                        
                    } else {
                        
                        state = .straight
                                            
                    }
                }
                
            } else if hand.hasEqualRank.contains(where: {$0.count == 4}){
                
                
                state = .fourCard
                
                
            } else {
                
                
                state = .highCard
                
            }
            
            
        }
        
        return state
    }
    
}
