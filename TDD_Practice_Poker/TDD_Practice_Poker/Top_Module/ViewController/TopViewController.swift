//
//  TopViewController.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/17.
//

import UIKit

class TopViewController: UIViewController {

    
    @IBOutlet weak var startGameBtn: UIButton!
    var topPresenter:TopPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startGameBtn.layer.cornerRadius = 5
        startGameBtn.backgroundColor = .systemBlue
        startGameBtn.addTarget(self, action: #selector(self.tappedStartGameBtn(_ :)), for: .touchUpInside)
    }
    
    @objc func tappedStartGameBtn(_ action:UIButton){
        topPresenter?.segutToPokerVC(storyboard:.main)
    }
}
