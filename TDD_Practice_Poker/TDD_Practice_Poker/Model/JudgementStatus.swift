//
//  JudgementStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

protocol JudgementStatusProtocol {
    func willStartJudge()
}

// MARK:- プレーヤー同士の役を比べて勝敗をつける
// ここはContainerでまとめて初期化する
struct JudgementStatus:JudgementStatusProtocol{
    
    
    // スタブ 用 ->OK
    var players = PlayerStatus()
    
    #warning("ここにUIの状態管理を行うPresenterのprotocolをDI")
    /*

     var players:PlayerStatus

     // これは別途、Containerにまとめていく予定
     init(players:PlayerList){
        self.players = players
     }
     */
    

    
    func willStartJudge() {
        
    }
        
    mutating func judge(){
        
        var judgeState:Judgement = .draw
        
        let myHandStatus = players.player_me.hand
            
        let otherHandStatus = players.player_other.hand
            
            if myHandStatus.handState < otherHandStatus.handState{
                
                judgeState = .lose
                
            } else if myHandStatus.handState > otherHandStatus.handState{
               
                judgeState = .win
                
            } else if myHandStatus.handState == otherHandStatus.handState{
                
                judgeState = self.compareCards(myHandStatus,otherHandStatus:otherHandStatus)
            }

        players.notifyResult(judgeState)
    }
    
}
