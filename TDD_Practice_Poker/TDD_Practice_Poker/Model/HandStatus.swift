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
        
        if hand.isEqualRank && (!hand.isEqualSuit){
            
            state = .pair
            
        } else if (!hand.isEqualRank){
            
            if hand.isContinuousRank && hand.isEqualSuit{
                
                state = .straightFlush
                
            } else if hand.isContinuousRank && !hand.isEqualSuit{
                state = .straight
                
            } else if !hand.isContinuousRank && hand.isEqualSuit {
                
                state = .flush
                
            } else if !hand.isContinuousRank && !hand.isEqualSuit {
                
                state = .highCard
                
            }
            
        } else {
            
            state = .nothing
            
        }
        
        
        return state
    }
    
}
