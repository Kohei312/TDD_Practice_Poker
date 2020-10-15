//
//  PokerViewControllerBuilder.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/09.
//

import Foundation
import UIKit

protocol PokerViewControllerBuilderProtocol{
    func build()
}

extension PokerViewController:PokerViewControllerBuilderProtocol{
    
    
    func build() {
        let interactor = PokerInteractor(handStatus: HandStatus(), gameFieldStatus: GameFieldStatus(), playerStatus_me: PlayerStatus(playerType: .me), playerStatus_other: PlayerStatus(playerType: .other), judgementStatus: JudgementStatus())
        var presenter = PokerPresenter(pokerInteractor: interactor)
        
        presenter.inject(pokerPresenterOutputProtocol: self)
        presenter.pokerInteractor.inject(interactorOutputProtocol: presenter)
        
        self.pokerPresenter = presenter

        setupCollectionViews()
        
        setupMenuButton()
        print("初期化")
    }
}
