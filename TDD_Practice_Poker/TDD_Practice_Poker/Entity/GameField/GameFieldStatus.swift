//
//  GameFieldStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation


// MARK:- GameFieldの状態を管理する
struct GameFieldStatus{
    
    // ここでオーガナイズ
    var gameSide:GameSide
    var gameField:GameField{
        didSet{
            
        }
    }
    
    init(){
        self.gameSide = .me
        self.gameField = .notStartJugdement
    }
    
}
