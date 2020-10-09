//
//  GameSide.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

// PlayerType, PlayerStatement, Sideが必要

#warning("カード交換アニメーションを制御 .completeで、PlayerTypeとPlayerStatementの状態が変わる")

enum GameSide{
    case me
    case other
    case judging
}
