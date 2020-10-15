//
//  PokerAnimationViewBuilder.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/15.
//

import Foundation
import UIKit

extension PokerViewController{
    func setupAnimationVIew(){
        let view = GameStateAnimationBaseView(frame: self.throwoutCardCollectionView.frame)
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
    
    // OK
    func shouldAppearAnimationView(_ shouldAppear:Bool,view:UIView?){
        UIView.animate(withDuration: 3, animations: {
            switch shouldAppear{
            case true:
                view?.isHidden = !shouldAppear
                view?.alpha = 0.5
            case false:
                view?.isHidden = shouldAppear
                view?.alpha = 0
            }
        }, completion:  { _ in
            switch shouldAppear{
            case true:
                view?.alpha = 0.5
            case false:
                view?.alpha = 0
            }
        })
    }
}
