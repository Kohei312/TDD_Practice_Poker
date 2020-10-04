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
    case straight
    case flush
    case straightFlush
}

struct HandStatus{
    
    var hand:Hand
    var handState:HandState{
        var state:HandState = .nothing
//        
//        if hand.hasEqualRank != [] && (hand.hasEqualSuit == []){
//            
//            state = .pair
//            
//        } else if (hand.hasEqualRank == []){
//            
//            if hand.hasContinuousRank != [] && hand.hasEqualSuit != []{
//                
//                state = .straightFlush
//                
//            } else if hand.hasContinuousRank != [] && hand.hasEqualSuit == []{
//                state = .straight
//                
//            } else if hand.hasContinuousRank == [] && hand.hasEqualSuit != [] {
//                
//                state = .flush
//                
//            } else if hand.hasContinuousRank == [] && hand.hasEqualSuit == []{
//                
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
