//
//  GameFieldStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

//enum GameField{
//    case notStartJugdement
//    case readyStartJudgement
//}

protocol GameFieldStatusProtocol{
    func willChangeGameFieldStatus()
}

// MARK:- プレーヤーがJugdeに進むか否かを監視する
struct GameFieldStatus:GameFieldStatusProtocol{
        
    
    #warning("以下に統一する")
    /*
     var dependency:PresenterClass?

     // これは別途、Containerにまとめていく予定
     // let judgement = Judgement(
     
     init(dependency:PresenterClass){
        self.dependency = dependency
     }
     
    var gameField:GameField = .notStartJudgement{
        didSet{
            JudgementStatusProtocol?.willStartJudge()
        }
     }
    
     
    // 各PlayerのreadyButtleを監視しておく
     // -> PlayerStatusからGameFieldStatusへ状態変化を伝える処理が必要
    func willChangeGameFieldStatus(){
     if players.readyButtleState == .readyButtle{
        gameField = .readyStartJudgement
     }
     */
    func willChangeGameFieldStatus() {
        print("changeGameFieldStatus")
    }
}

