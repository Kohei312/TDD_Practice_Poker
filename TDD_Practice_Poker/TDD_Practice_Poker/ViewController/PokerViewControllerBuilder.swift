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
        print("初期化")
    }
    
    func setupCollectionViews(){
        playerCardCollectionView.registerCell(PlayerCardCollectionViewCell.self)
        playerCardCollectionView.registerLayout(layout: PlayerCardCollectionViewLayout())
        playerCardCollectionView.delegate = self
        playerCardCollectionView.dataSource = self
        playerCardCollectionView.dropDelegate = self
        playerCardCollectionView.dragDelegate = self
        playerCardCollectionView.dragInteractionEnabled = true
        
        throwoutCardCollectionView.registerCell(ThrowoutCardCollectionViewCell.self)
        throwoutCardCollectionView.registerLayout(layout: ThrowOutCardsCollectionViewLayout())
        throwoutCardCollectionView.delegate = self
        throwoutCardCollectionView.dataSource = self
        throwoutCardCollectionView.dropDelegate = self
        throwoutCardCollectionView.dragInteractionEnabled = true
        
        cpuCardCollectionView.registerCell(CPUCardCollectionViewCell.self)
        cpuCardCollectionView.registerLayout(layout: CPUCardsCollectionViewLayout())
        cpuCardCollectionView.delegate = self
        cpuCardCollectionView.dataSource = self
    }
    
//    func setupChangePlayerStateButton(){
//        self.changePlayerStateButton.addTarget(self,action: #selector(self.tappedChangeCardBtn(_ :)),for: .touchUpInside)
//        self.changePlayerStateButton.layer.cornerRadius = self.changePlayerStateButton.frame.width / 2
//    }
}
