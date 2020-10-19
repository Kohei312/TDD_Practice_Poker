//
//  Player.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/04.
//

import Foundation

enum PlayerAction:Equatable{
    case tappedRestartBtn
    case tappedTurnoverBtn
    case tappedBattleBtn
}

enum PlayerStatement:Equatable{
    case thinking
//    case action(PlayerAction)
    case waiting
    case isReadyButtle
}

struct Player{
    
    var playerType:PlayerType
    
    init(playerType:PlayerType){
        self.playerType = playerType
    }
    
    var playerStatement:PlayerStatement = .thinking
    var changeCount = 3{
        didSet{
            print(changeCount)
        }
    }
}

