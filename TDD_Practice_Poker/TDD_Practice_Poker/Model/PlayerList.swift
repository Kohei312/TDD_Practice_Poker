//
//  PlayerList.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

// 仮実装OK
struct PlayerList{

    var player_me:Player
    var player_other:Player
    init(){
        self.player_me = Player(playerType: .me, hand: Hand())
        self.player_other = Player(playerType: .other, hand: Hand())
        
    }
    
}
