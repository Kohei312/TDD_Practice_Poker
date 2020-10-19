//
//  TopPresenter.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/19.
//

import Foundation


struct TopPresenter{
    
    var wireframe: TopRouterWireframe
    init(wireframe:TopRouterWireframe){
        self.wireframe = wireframe
    }
    
    func segutToPokerVC(storyboard:RouterState){
        wireframe.segueToPokerVC(storyboard: storyboard)
    }
    
}
