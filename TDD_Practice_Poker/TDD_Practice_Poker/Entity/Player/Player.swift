//
//  Player.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/04.
//

import Foundation

#warning("ターンのコントロール時に必要")
enum PlayerType{
    case me
    case other
}
enum ReadyButtleState{
    case none
    case yup
}

struct Player{
    
    var playerType:PlayerType
    var isReadyButtle:ReadyButtleState = .none
    var changeCount = 3
}
