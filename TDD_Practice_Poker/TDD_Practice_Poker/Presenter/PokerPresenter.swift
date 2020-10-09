//
//  PokerPresenter.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/08.
//

import Foundation

protocol PokerPresenterOutputProtocol{
    func updateUI(judgement:Judgement)
}

public struct PokerPresenter:InteractorOutputProtocol{

    var pokerInteractor:PokerInteractor
    var pokerPresenterOutputProtocol:PokerPresenterOutputProtocol?
    var result:Judgement = .draw
    
    init(pokerInteractor:PokerInteractor){
        self.pokerInteractor = pokerInteractor
    }
    
    // ViewControllerからDI
    mutating func inject(pokerPresenterOutputProtocol:PokerPresenterOutputProtocol){
        self.pokerPresenterOutputProtocol = pokerPresenterOutputProtocol
    }
    
    mutating func callPresenter(_ gameSide:GameSide,judgeStatus:Judgement?) {
        print("各UIパーツに状態変更を指示")
        if let judge = judgeStatus{
            print("結果は :",judge)
            pokerPresenterOutputProtocol?.updateUI(judgement: judge)
        }
    }
    
    // MARK:- ViewControllerからの入力を受け,PokerInteractorに伝達
}
