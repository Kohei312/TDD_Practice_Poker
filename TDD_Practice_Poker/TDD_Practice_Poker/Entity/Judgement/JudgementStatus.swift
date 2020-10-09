//
//  JudgementStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

protocol JudgementStatusProtocol {
    mutating func judge(handStatus:HandStatus)
}


// MARK:- プレーヤー同士の役を比べて勝敗をつける
// ここはContainerでまとめて初期化する
struct JudgementStatus:JudgementStatusProtocol{
    
    
    var interactorInputProtocol:InteractorInputProtocol?

    
    mutating func judge(handStatus:HandStatus){
        
        var judgeState:Judgement = .draw
        
        let myHand = handStatus.myPlayerHand
            
        let otherHand = handStatus.otherPlayerHand
            
            if myHand.handState < otherHand.handState{
                
                judgeState = .lose
                
            } else if myHand.handState > otherHand.handState{
               
                judgeState = .win
                
            } else if myHand.handState == otherHand.handState{
                
                judgeState = self.compareCards(myHand,otherHandStatus:otherHand)
            }

        interactorInputProtocol?.notify(.result, judgeStatus: judgeState)
    }
    
}
