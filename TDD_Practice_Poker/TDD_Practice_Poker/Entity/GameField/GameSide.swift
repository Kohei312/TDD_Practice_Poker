//
//  GameSide.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

// PlayerType, PlayerStatement, Sideが必要

#warning("カード交換アニメーションを制御 .completeで、PlayerTypeとPlayerStatementの状態が変わる")
enum CardChanging{
    case choosing // 相手ターンの状態、選択前
    case pass
    case change
    case complete // カードの交換が終了した
}

enum GameSide{
    case me
    case other
}
