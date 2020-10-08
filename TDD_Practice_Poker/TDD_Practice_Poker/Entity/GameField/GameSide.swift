//
//  GameSide.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation


enum GameSide{
    case inPlaying
    case changeTurn(Player,CardChanging,PlayerStatement)
    case finished
}

#warning("カード交換アニメーションを制御 .completeで、PlayerTypeとPlayerStatementの状態が変わる")
enum CardChanging{
    case none
    case pass
    case changing
    case complete
}

#warning("PlayerStateを以下に差し替え")
enum PlayerStatement{

    case thinking
    case changeTurn

}
