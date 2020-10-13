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
//        addLongTapGesture()
        
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
    
    func addLongTapGesture() {
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(longTap(gesture:)))
        playerCardCollectionView.addGestureRecognizer(tapGesture)
     }
     
     @objc func longTap(gesture: UITapGestureRecognizer) {
         switch gesture.state {
         // ロングタップの開始時
         case .began:
//            .indexPathForItem(at: gesture.location(in: collectionView))
            guard let selectedIndexPath = playerCardCollectionView.indexPathForItem(at:gesture.location(in: playerCardCollectionView)) else {
                 break
             }
            let i = self.playerCardCollectionView.visibleCells(with: PlayerCardCollectionViewCell.self)[selectedIndexPath.row]
            if i.cardChangeState == .canChange{
                print("hoge")
                playerCardCollectionView.dragInteractionEnabled = true
            }
            playerCardCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
         // セルの移動中
         case .changed:
            playerCardCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
         // セルの移動完了時
         case .ended:
            playerCardCollectionView.endInteractiveMovement()
         default:
            playerCardCollectionView.cancelInteractiveMovement()
         }
     }
    
}
