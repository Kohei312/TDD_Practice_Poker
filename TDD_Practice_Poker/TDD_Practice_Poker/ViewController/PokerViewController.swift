//
//  PokerViewController.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import UIKit
import CircleMenu

class PokerViewController: UIViewController,PokerPresenterOutputProtocol{
    
    var pokerPresenter:PokerPresenter?
    var result:Judgement = .draw
    
    // MARK:- PlayerCollectionViewの制御プロパティ
    var removeCellHashValues = RemoveCellHashValuesProperty()
    var moveCardStatuses = MoveCardStatusProperty()

    // MARK:- MenuButtonの制御プロパティ
    var circleMenuButtonProperty = CircleMenuButtonProperty()
    
    @IBOutlet weak var cpuCardCollectionView: UICollectionView!
    @IBOutlet weak var throwoutCardCollectionView: UICollectionView!
    @IBOutlet weak var playerCardCollectionView: UICollectionView!
    var circleMenuButton:CircleMenu?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.build()
    }

    
    func updateJudgementUI(judgement:Judgement) {
        print("presenterから呼ばれる")
        self.result = judgement
        
        // Presenterからの伝達で、UI更新
    }
    
    func updateGameStateUI() {
        print("gamestateを更新")
        // Presenterからの伝達で、UI更新
        changePlayerCollectionViewDragEnable()
        changeCircleMenuButtonIsHidden()
    }
}

extension PokerViewController{
    
    func changePlayerCollectionViewDragEnable(){
        playerCardCollectionView.dragInteractionEnabled =
            playerCardCollectionView.dragInteractionEnabled ? false : true
        print(playerCardCollectionView.dragInteractionEnabled)
    }
    
    func changeCircleMenuButtonIsHidden(){
        guard let menuButton = circleMenuButton else {return}
        circleMenuButton?.isHidden = menuButton.isHidden ? false : true
    }
}
