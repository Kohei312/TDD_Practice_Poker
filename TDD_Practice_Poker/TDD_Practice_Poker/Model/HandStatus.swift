//
//  HandStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import Foundation

enum HandState{
    case nothing
    case pair
    case flush
    case highCard
    case straight
    case straightFlush
}

struct HandStatus{
    
    var hand:Hand
    
    func updateHandState()->HandState{
        
        var handState:HandState = .nothing
        
        if hand.isEqualRank && (hand.isEqualSuit != true){
            
            handState = .pair
            
        } else if (hand.isEqualRank != true){
            
            if hand.isContinuousRank{
                
                if hand.isEqualSuit {
                    
                    handState = .straightFlush
                
                } else {
                    
                    handState = .straight
                    
                }
            
            } else {
                
                if hand.isEqualSuit {
                    
                    handState = .flush
                
                } else {
                    
                    handState = .highCard
                    
                }
                
            }
            
//        else if (hand.isEqualRank != true) && hand.isEqualSuit{
//
//            handState = .flush
//
//        } else if (hand.isEqualRank != true ) && (hand.isEqualSuit != true){
//
//            handState = .highCard
        
        } else {
            
            handState = .nothing
        
        }


        return handState
    }
    
}
