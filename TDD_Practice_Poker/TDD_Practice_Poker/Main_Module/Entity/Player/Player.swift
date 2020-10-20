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
    var interactorInputProtocol:InteractorInputProtocol?
    
    var playerStatement:PlayerStatement = .thinking
    var changeCount = 3
    
    init(playerType:PlayerType){
        self.playerType = playerType
    }
    
    mutating func changePlayerStatement(_ playerType:PlayerType, playerStatement:PlayerStatement){
        self.playerStatement = playerStatement
    }
    
    mutating func decrementChangeCount(_ playerType:PlayerType){
        self.changeCount -= 1
        interactorInputProtocol?.checkGameStatement(playerType)
    }
    
    mutating func callReadyButtle(_ playerType:PlayerType){
        self.changeCount = 0
        self.playerStatement = .isReadyButtle
        interactorInputProtocol?.checkGameStatement(playerType)
    }
    
    mutating func decrement(){
        changeCount -= 1
//        interactorInputProtocol?.changePlayerStatement(.me)
    }
}

