//
//  TopRouter.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/19.
//

import Foundation

protocol TopRouterWireframe{
    func segueToPokerVC(storyboard:RouterState)
}

struct TopRouter:TopRouterWireframe{
    
    var wireframe:TopRouterWireframe?
    unowned var topViewController:TopViewController
    
    init(storyboard:RouterState){
        self.topViewController = storyboard.initiateVC(TopViewController.self)
        self.build()
    }
    
    func build() {
        let topPresenter = TopPresenter(wireframe: self)
        self.topViewController.topPresenter = topPresenter
    }
    
    func segueToPokerVC(storyboard:RouterState){
        let pokerViewController = storyboard.initiateVC(PokerViewController.self)
        pokerViewController.isModalInPresentation = true
        pokerViewController.modalPresentationStyle = .fullScreen
        topViewController.present(pokerViewController, animated: true, completion: nil)
    }
}
