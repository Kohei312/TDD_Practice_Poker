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
    func changeGameFieldStatus()
}

// MARK:- プレーヤーがJugdeに進むか否かを監視する
struct GameFieldStatus:GameFieldStatusProtocol{
    
    var players:[Player]
    /*
    var gameField:GameField = .notStartJudgement{
        didSet{
            JudgementStatusProtocol?.willStartJudge()
        }
     }
    
     
    // 各PlayerのreadyButtleを監視しておく
     // -> PlayerStatusからGameFieldStatusへ状態変化を伝える処理が必要
     
    func changeGameFieldStatus(){
     if players.readyButtleState == .readyButtle{
        gameField = .readyStartJudgement
     }
     */
    func changeGameFieldStatus() {
        print("changeGameFieldStatus")
    }
}

