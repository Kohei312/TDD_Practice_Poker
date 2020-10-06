//
//  HandStatusProtocol.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/06.
//

import Foundation

extension HandStatus:HandStatusProtocol{
    
    func manageHandState()->HandState{
    
        var state:HandState = .nothing
        
        if hand.hasAllEqualSuit == [] &&
            hand.hasEqualRank == [:] &&
            hand.hasContinuousRank == []{
            
            state = .highCard
            
        } else {
            
            if hand.hasAllEqualSuit != []{
   
                if hand.hasContinuousRank == []{
                    
                    state = .flush
                    
                } else if hand.hasContinuousRank.count == 5 {
                    
                        state = checkFlushStatus(hand.hasContinuousRank)
                }
                
            } else if checkCardPairType(pairType: .onePair){
                
                if checkCardPairType(pairType: .threeCard){
                    
                    state = .fullHouse
                    
                } else {
                   
                    if hand.hasEqualRank.filter({$0.value == .onePair}).count == 2{
                        
                        state = .twoPair
                        
                    } else {
                    
                        state = .onePair
                    }
                }
                
            } else if checkCardPairType(pairType: .threeCard){
                
                
                state = .threeCard
                
                
            } else if checkCardPairType(pairType: .fourCard){
                
                
                state = .fourCard
                
                
            }  else if hand.hasContinuousRank.count == 5 {
                
                state = checkStraightStatus(hand.hasContinuousRank)
                
            } else {
                
                state = .highCard
                
            }
            
            
        }
        return state
    }
 
    func checkCardPairType(pairType:HandState) -> Bool{
        return hand.hasEqualRank.values.contains(where: {$0 == pairType})
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
