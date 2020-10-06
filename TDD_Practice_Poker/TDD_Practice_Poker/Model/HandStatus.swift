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
            hand.hasEqualRank == [:] &&
            hand.hasContinuousRank == []{
            
            state = .highCard
            
        } else {
            
            if hand.hasEqualSuit != []{
                if hand.hasContinuousRank == []{
                    
                    state = .flush
                    
                } else if hand.hasContinuousRank.contains(where: {$0.count == 5}) {
                    
                    let continuousCards = hand.hasContinuousRank.compactMap({$0.compactMap({$0.rank })})
                    for cards in continuousCards {
                        // checkFlushStatus()
                        state = checkFlushStatus(cards)
                    }
                }
            } else if hand.hasEqualRank.values.contains(where: {$0 == HandState.onePair}){
                
                if hand.hasEqualRank.values.contains(where: {$0 == HandState.threeCard}){
                    
                    state = .fullHouse
                    
                } else {
                   
                    if hand.hasEqualRank.filter({$0.value == .onePair}).count == 2{
                        
                        state = .twoPair
                        
                    } else {
                    
                        print(hand.hasEqualRank.filter({$0.value == .onePair}).count)
                        state = .onePair
                    }
                }
                
            } else if  hand.hasEqualRank.values.contains(where: {$0 == HandState.threeCard}){
                
                
                state = .threeCard
                
                
            } else if  hand.hasEqualRank.values.contains(where: {$0 == HandState.fourCard}){
                
                
                state = .fourCard
                
                
            }  else if hand.hasContinuousRank.contains(where: {$0.count == 5}) {
                
//                print("なかみ",hand.hasContinuousRank)
                let continuousCards = hand.hasContinuousRank.compactMap({$0.compactMap({$0.rank })})
                
                for cards in continuousCards {
                    
                    state = checkStraightStatus(cards)
                }
                
                
            } else {
                
                state = .highCard
                
            }
            
            
        }
        
        return state
    }
    
    func checkFlushStatus(_ cards:[Card.Rank])->HandState{
        
        var state:HandState = .flush
        
        if cards.contains(where: {$0 == .four}) && cards.contains(where: {$0 == .three}) && cards.contains(where: {$0 == .two}) && cards.contains(where: {$0 == .ace}) && cards.contains(where: {$0 == .king}){
            
            state = .flush
            
        } else if cards.contains(where: {$0 == .three}) && cards.contains(where: {$0 == .two}) && cards.contains(where: {$0 == .ace}) && cards.contains(where: {$0 == .king}) && cards.contains(where: {$0 == .queen}){
            
            state = .flush
            
        } else if cards.contains(where: {$0 == .two}) && cards.contains(where: {$0 == .ace}) && cards.contains(where: {$0 == .king}) && cards.contains(where: {$0 == .queen}) && cards.contains(where: {$0 == .jack}){
            
            state = .flush
            
        } else if cards.contains(where: {$0 == .ace}) && cards.contains(where: {$0 == .king}) && cards.contains(where: {$0 == .queen}) && cards.contains(where: {$0 == .jack}) && cards.contains(where: {$0 == .ten}){
            
            state = .royalFlush
            
        } else {
            
            state = .straightFlush
        }
        return state
    }
    
    func checkStraightStatus(_ cards:[Card.Rank])->HandState{
        
        var state:HandState = .highCard
        
        if cards.contains(where: {$0 == .four}) && cards.contains(where: {$0 == .three}) && cards.contains(where: {$0 == .two}) && cards.contains(where: {$0 == .ace}) && cards.contains(where: {$0 == .king}){
            
            state = .highCard
            
        } else if cards.contains(where: {$0 == .three}) && cards.contains(where: {$0 == .two}) && cards.contains(where: {$0 == .ace}) && cards.contains(where: {$0 == .king}) && cards.contains(where: {$0 == .queen}){
            
            state = .highCard
            
        } else if cards.contains(where: {$0 == .two}) && cards.contains(where: {$0 == .ace}) && cards.contains(where: {$0 == .king}) && cards.contains(where: {$0 == .queen}) && cards.contains(where: {$0 == .jack}){
            
            state = .highCard
            
        } else {
           
            state = .straight
                                
        }
        
        return state
    }
    
}

