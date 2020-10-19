//
//  PokerInteractorProtocol.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/09.
//

import Foundation

protocol InteractorInputProtocol{
    func notify(_ gameSide:GameSide,judgement:Judgement?)
    func completeCPUTurn(playerStatement:PlayerStatement)
    func changePlayerStatement(_ playerType:PlayerType)
}

protocol InteractorOutputProtocol{
    func callPresenter(_ gameSide:GameSide,judgement:Judgement?,myHand:Hand?,otherHand:Hand?)
}
