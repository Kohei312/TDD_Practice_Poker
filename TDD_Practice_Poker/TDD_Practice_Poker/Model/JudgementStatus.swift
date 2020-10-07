//
//  JudgementStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

protocol JudgementStatusProtocol {
    func willStartJudge()
    func notifyResult()
}

// MARK:- プレーヤー同士の役を比べて勝敗をつける
// ここはContainerでまとめて初期化する
struct JudgementStatus:JudgementStatusProtocol{
    
    
    // スタブ 用 ->OK
    var players = PlayerList()
    
    #warning("ここにUIの状態管理を行うPresenterのprotocolをDI")
    /*
     var dependency:PresenterClass?

     // これは別途、Containerにまとめていく予定
     // let judgement = Judgement(
     
     init(dependency:PresenterClass,players:PlayerList){
        self.dependency = dependency
        self.players = players
     }
     */
    

    
    func willStartJudge() {
        
    }
    
    func notifyResult() {
        #warning("DIしたPresenterへ結果を返却")
//        dependency?.hogehoge()
    }
    
    mutating func hoge()->Judgement{
        
        var judgeState:Judgement = .draw
        
        let myHandStatus = players.player_me.hand
        
//        for otherPlayer in otherPlayers{
            
        let otherHandStatus = players.player_other.hand
            
            if myHandStatus.handState < otherHandStatus.handState{
                
                judgeState = .lose
                
            } else if myHandStatus.handState > otherHandStatus.handState{
               
                judgeState = .win
                
            } else if myHandStatus.handState == otherHandStatus.handState{
                
                judgeState = self.compareCards(myHandStatus,otherHandStatus:otherHandStatus)
            }
//        }
        return judgeState
    }
    
}
