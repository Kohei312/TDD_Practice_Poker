//
//  PokerInteractorProtocol.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/09.
//

import Foundation

protocol InteractorInputProtocol{
    func notify(_ gameSide:GameSide,judgement:Judgement?)
    mutating func completeCPUTurn(playerStatement:PlayerStatement)
    mutating func checkGameStatement(_ playerType:PlayerType)
}

protocol InteractorOutputProtocol{
    func callPresenter(_ gameSide:GameSide,judgement:Judgement?,myHand:Hand?,otherHand:Hand?)
}
