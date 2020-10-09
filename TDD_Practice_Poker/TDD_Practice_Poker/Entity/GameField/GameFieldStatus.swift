//
//  GameFieldStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation


// MARK:- GameFieldの状態を管理する
struct GameFieldStatus{
    
    
    var interactorInputProtocol:InteractorInputProtocol?
    
    // ここでオーガナイズ
    var gameSide:GameSide{
        didSet{
            interactorInputProtocol?.notify(gameSide,judgeStatus: nil)
        }
    }
    
    init(){
        self.gameSide = .playerType(.me)
    }
    
    
    
}
