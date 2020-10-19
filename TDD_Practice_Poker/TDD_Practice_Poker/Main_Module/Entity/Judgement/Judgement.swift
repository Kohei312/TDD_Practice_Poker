//
//  Judgement.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

protocol JudgementProtocol{
    
    func compareCards(_ myHandStatus:Hand, otherHandStatus:Hand)->Judgement
    func compareCardRanks(myCardRank:Card.Rank,otherCardRank:Card.Rank)->Judgement
    
    func makeLestCardRanks(_ handStatus:Hand,reduceRanks:[Card.Rank])->[Card.Rank]
    func checkLestRank(_ lestRanks:[Card.Rank],returnStrength:RankStrength)->Card.Rank
    
    func checkTwoPairRank(_ handStatus:Hand,returnStrength:RankStrength)->Card.Rank
    func checkStraightStrongRank(_ handStatus:Hand)->Card.Rank
    func checkFullHousePairs(_ handStatus:Hand,returnPairType:HandState)->Card.Rank
}


public enum Judgement:Equatable{
    case win
    case draw
    case lose
}
