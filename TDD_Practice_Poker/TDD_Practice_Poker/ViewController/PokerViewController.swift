//
//  PokerViewController.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import UIKit

class PokerViewController: UIViewController,PokerPresenterOutputProtocol {
    
    var pokerPresenter:PokerPresenter?
    var result:Judgement = .draw
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.build()
    }
    
    

    func updateUI(judgement:Judgement) {
        print("presenterから呼ばれる")
        self.result = judgement
    }

}

