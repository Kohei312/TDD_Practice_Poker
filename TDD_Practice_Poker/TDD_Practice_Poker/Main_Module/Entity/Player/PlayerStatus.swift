//
//  PlayerList.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

// 仮実装OK
class PlayerStatus{
    
    var player_me:Player
    var player_other:Player
    var interactorInputProtocol:InteractorInputProtocol?
    
    init(){
        self.player_me = Player(playerType:.me)
        self.player_other = Player(playerType: .other)
    }

    
    func changePlayerStatement(_ playerType:PlayerType, playerStatement:PlayerStatement){
        
        switch playerType{
        
        case .me:
            player_me.playerStatement = playerStatement
        case .other:
            player_other.playerStatement = playerStatement
        }
    }
    
    func decrementChangeCount(_ playerType:PlayerType){
        switch playerType{
        
        case .me:
            player_me.changeCount -= 1
        case .other:
            player_other.changeCount -= 1
        }
        
        interactorInputProtocol?.changePlayerStatement(playerType)
        
    }
    
    func callReadyButtle(_ playerType:PlayerType){
        switch playerType{
        
        case .me:
            player_me.playerStatement = .isReadyButtle
            player_me.changeCount = 0
        case .other:
            player_other.playerStatement = .isReadyButtle
            player_other.changeCount = 0
        }
        interactorInputProtocol?.changePlayerStatement(playerType)
    }
}
