//
//  GameFieldStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation


// MARK:- GameFieldの状態を管理する
struct GameFieldStatus{
    
    // JudgementStatusProtocolをDI
//    var judgementStatusProtocol:JudgementStatusProtocol?

    // ここでオーガナイズ
    var gameSide:GameSide
    var gameField:GameField{
        didSet{
//            JudgementStatusProtocol?.judge()
        }
    }
    
    init(){
//  init(output:JudgementStatusProtocol){
//        self.judgementStatusProtocol = output
        self.gameSide = .me
        self.gameField = .notStartJugdement
    }
    
    
    
}
