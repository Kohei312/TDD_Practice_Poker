//
//  Player.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/04.
//

import Foundation

enum PlayerAction:Equatable{
    case choosing // 相手ターンの状態、選択前
    case pass
    case change
    case complete // カードの交換が終了した
}

enum PlayerStatement:Equatable{
    case thinking
    case action(PlayerAction)
    case waiting
    case isReadyButtle
}

struct Player{
    
    var playerType:PlayerType
    var playerStatement:PlayerStatement = .thinking
    var changeCount = 3{
        didSet{
            print(changeCount)
        }
    }
}

