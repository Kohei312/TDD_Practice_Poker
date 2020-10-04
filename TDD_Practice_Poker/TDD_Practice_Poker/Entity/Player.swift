//
//  Player.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/04.
//

import Foundation

enum PlayerType{
    case me
    case other
}


struct Player{
    
    var playerType:PlayerType
    var handStatus:HandStatus
    
}
