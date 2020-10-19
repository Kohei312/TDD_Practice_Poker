//
//  PokerRouter.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/19.
//

import Foundation

protocol PokerRouterWireframe{
    func dissmissFromPokerVC()
}

struct PokerRouter:PokerRouterWireframe{
    
    unowned var pokerViewController:PokerViewController
    
    init(vc:PokerViewController){
        self.pokerViewController = vc
        self.build()
    }
        
    func build() {
        
        let interactor = PokerInteractor(handStatus: HandStatus(), playerStatus: PlayerStatus(), judgementStatus: JudgementStatus())
        var presenter = PokerPresenter(pokerInteractor: interactor, pokerRouter: self)
        
        presenter.inject(pokerPresenterOutputProtocol: pokerViewController)
        presenter.pokerInteractor.inject(interactorOutputProtocol: presenter)
        
        pokerViewController.pokerPresenter = presenter
    }
    
    func dissmissFromPokerVC(){
        pokerViewController.dismiss(animated: true, completion: nil)
    }
    
}
