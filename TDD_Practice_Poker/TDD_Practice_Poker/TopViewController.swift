//
//  TopViewController.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/17.
//

import UIKit

class TopViewController: UIViewController {

    
    @IBOutlet weak var startGameBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        startGameBtn.layer.cornerRadius = 5
        startGameBtn.backgroundColor = .systemBlue
        startGameBtn.addTarget(self, action: #selector(self.tappedStartGameBtn(_ :)), for: .touchUpInside)
    }
    
    @objc func tappedStartGameBtn(_ action:UIButton){
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        let pokerVC:UIViewController = storyboard.instantiateViewController(withIdentifier: "PokerViewController")
        pokerVC.isModalInPresentation = true
        pokerVC.modalPresentationStyle = .fullScreen
        self.present(pokerVC, animated: true, completion: nil)
    }
}
