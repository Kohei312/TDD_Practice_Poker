//
//  PokerInteractorProtocol.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/09.
//

import Foundation

protocol InteractorInputProtocol{
    mutating func notify(_ gameSide:GameSide,judgeStatus:Judgement?)
    mutating func completeCPUTurn()
}

protocol InteractorOutputProtocol{
    mutating func callPresenter(_ gameSide:GameSide,judgeStatus:Judgement?,myHand:Hand?,otherHand:Hand?)
    mutating func callUpdatePlayerUI()
}
