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
    case pair
    case flush
    case straight
    case threeCard
    case straightFlush
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
                
                state = .pair
                
            } else if hand.hasEqualSuit.contains(where: {$0.count == 3}){
                
                if hand.hasContinuousRank.contains(where: {$0.count == 3}){
                    
                    let i = hand.hasContinuousRank.compactMap({$0.compactMap({$0.rank })})
                    for j in i {
                        
                        if j.contains(where: {$0 == .ace}) && j.contains(where: {$0 == .two}) && j.contains(where: {$0 == .king}){
                            
                            state = .flush
                        } else {
                            state = .straightFlush
                        }
                    }

                } else {
                    
                    state = .flush
                    
                }

                
            } else if hand.hasContinuousRank.contains(where: {$0.count == 3}) {
                
                let i = hand.hasContinuousRank.compactMap({$0.compactMap({$0.rank })})
                for j in i {
                    if j.contains(where: {$0 == .ace}) && j.contains(where: {$0 == .two}) && j.contains(where: {$0 == .king}){
                        
                        state = .highCard
                            
                    } else {
                        
                        state = .straight
                                            
                    }
                }
                
            } else if hand.hasEqualRank.contains(where: {$0.count == 3}){
                
                state = .threeCard
                
            } else {
                
                state = .highCard
                
            }
            
            
        }
        
//        if hand.hasEqualRank != [] &&
//           hand.hasEqualSuit == []{
//
//            if hand.hasEqualRank.contains(where: {$0.count == 2}) {
//                // ok
//                state = .pair
//
//            } else if hand.hasEqualRank.contains(where: {$0.count == 3}){
//                // OK
//                state = .threeCard
//            }
//
//
//        } else if (hand.hasEqualRank == []){
//
//            if hand.hasContinuousRank != [] && hand.hasEqualSuit != []{
//
//                state = .straightFlush
//
//            } else if hand.hasContinuousRank != [] &&
//                      hand.hasContinuousRank.contains(where: {$0.count == 3}) &&
//                      hand.hasEqualSuit == []{
//                // ok
//                state = .straight
//
//            } else if hand.hasContinuousRank == [] &&
//                      hand.hasEqualSuit != [] &&
//                      hand.hasEqualSuit.contains(where: {$0.count == 3})  {
//                // ok
//                state = .flush
//
//            } else if hand.hasContinuousRank == [] && hand.hasEqualSuit == []{
//                // ok
//                state = .highCard
//
//            }
//
//        } else {
//
//            state = .nothing
//
//        }
        
        
        return state
    }
    
}
