//
//  GameSide.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

public enum GameSide:Equatable{
    case playerType(PlayerType)
    case beforeJudgement
    case result
}
