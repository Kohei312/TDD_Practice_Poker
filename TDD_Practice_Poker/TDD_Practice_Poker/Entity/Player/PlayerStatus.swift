//
//  PlayerList.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

// 仮実装OK
struct PlayerStatus{
    
    var player:Player
    var interactorInputProtocol:InteractorInputProtocol?
    
    init(playerType:PlayerType){
        self.player = Player(playerType: playerType)
    }
    
    mutating func changePlayerStatement(_ playerStatement:PlayerStatement){
        player.playerStatement = playerStatement
    }
    
    mutating func decrementChangeCount()->Int{
        player.changeCount -= 1
        return player.changeCount
    }
    
    mutating func callReadyButtle(){
        player.playerStatement = .isReadyButtle
        player.changeCount = 0
    }
}
