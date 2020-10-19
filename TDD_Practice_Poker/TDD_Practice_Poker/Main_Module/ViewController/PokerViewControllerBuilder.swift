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
        self.pokerRouter = PokerRouter(vc: self)
        self.pokerRouter?.build()
        
        setupCollectionViews()
        
        setupMenuButton()
        
        setupAnimationVIew()
    }
}
