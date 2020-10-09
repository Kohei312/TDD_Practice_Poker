//
//  Player.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/04.
//

import Foundation

enum PlayerStatement{
    case thinking
    case changeTurn
    case waiting
    case isReadyButtle
}

struct Player{
    
    var playerType:PlayerType
    var playerStatement:PlayerStatement = .waiting
    var changeCount = 3
}

