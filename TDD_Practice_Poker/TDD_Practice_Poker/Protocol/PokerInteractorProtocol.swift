//
//  PokerInteractorProtocol.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/09.
//

import Foundation

protocol InteractorInputProtocol{
    mutating func notify(_ gameSide:GameSide,judgeStatus:Judgement?)
}

protocol InteractorOutputProtocol{
    mutating func callPresenter(_ gameSide:GameSide,judgeStatus:Judgement?)
}

extension PokerInteractor{
    // MARK:- InteractorInputProtocol
    mutating func notify(_ gameSide:GameSide,judgeStatus:Judgement?) {
        switch gameSide{
        case .playerType(.me),.playerType(.other):
            interactorOutputProtocol?.callPresenter(gameSide,judgeStatus: nil)
        case .result:
            interactorOutputProtocol?.callPresenter(gameSide,judgeStatus: judgeStatus)
        }
    }
}
