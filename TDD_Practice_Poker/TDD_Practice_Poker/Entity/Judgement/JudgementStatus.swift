//
//  JudgementStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

protocol JudgementStatusProtocol {
    func judge()
}

// Presenterへ伝達する
protocol NotifyJudgementResultProtocol{
    func notifyResult()
}

// MARK:- プレーヤー同士の役を比べて勝敗をつける
// ここはContainerでまとめて初期化する
struct JudgementStatus:JudgementStatusProtocol{
    
    
    // スタブ 用 ->OK ここで直接初期化しない
    private var players = PlayerStatus(playerType: .me)
    
    #warning("ここにUIの状態管理を行うPresenterのprotocolをDI")
    /*
     private var players:PlayerStatus
     private var dependency:PresenterClass
     
     // これは別途、Containerにまとめていく予定
     init(players:PlayerStatus,dependency:PresenterClass){
        self.players = players
        self.dependency = dependency
     }
     */
    
    func judge(){
//        
//        var judgeState:Judgement = .draw
//        
//        let myHandStatus = players.getPlayer(.me).hand
//            
//        let otherHandStatus = players.getPlayer(.other).hand
//            
//            if myHandStatus.handState < otherHandStatus.handState{
//                
//                judgeState = .lose
//                
//            } else if myHandStatus.handState > otherHandStatus.handState{
//               
//                judgeState = .win
//                
//            } else if myHandStatus.handState == otherHandStatus.handState{
//                
//                judgeState = self.compareCards(myHandStatus,otherHandStatus:otherHandStatus)
//            }

//        dependency?.notifyResult(judgeState)
    }
    
}
