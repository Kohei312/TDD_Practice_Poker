//
//  PokerAnimationViewBuilder.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/15.
//

import Foundation
import UIKit

// MARK:- ゲームの進行状態を示すアニメーションView
extension PokerViewController{
    func setupAnimationVIew(){
        let view = GameStateAnimationView(frame: self.throwoutCardCollectionView.bounds)
        view.addItemLabelsToAnimationBaseView()

        self.animationView = view
        self.view.addSubview(self.animationView!)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.throwoutCardCollectionView.leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.throwoutCardCollectionView.topAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.throwoutCardCollectionView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.throwoutCardCollectionView.bottomAnchor).isActive = true

        view.isHidden = true
        view.alpha = 0
    }
}
