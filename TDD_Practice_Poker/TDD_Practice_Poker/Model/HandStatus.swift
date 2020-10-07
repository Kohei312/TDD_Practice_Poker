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

protocol HandStatusProtocol{
    func manageHandState() -> HandState
    func checkCardPairType(pairType:HandState) -> Bool
    func checkFlushStatus(_ cards:[Card.Rank]) -> HandState
    func checkStraightStatus(_ cards:[Card.Rank]) -> HandState
}

// MARK:- 手札の役の状態を監視する
struct HandStatus{
    
    var hand:Hand
    var handState:HandState{
        manageHandState()
    }
    
}

