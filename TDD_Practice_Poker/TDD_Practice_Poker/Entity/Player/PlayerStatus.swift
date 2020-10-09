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
    
    init(playerType:PlayerType){
        self.player = Player(playerType: playerType)
    }
  
    func changePlayerCard(_ playerType:PlayerType,index:Int){
        
//        if player.changeCount == 0{
//            return
//        } else if player.changeCount > 0 {
//            player.hand.changeCard(index)
//        }
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
