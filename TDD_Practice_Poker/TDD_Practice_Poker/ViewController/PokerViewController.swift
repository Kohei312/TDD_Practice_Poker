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

    
    func updateJudgementUI(judgement: Judgement, myHand: Hand, otherHand: Hand) {
        // スタブ OK
        print("presenterから呼ばれる")
        self.result = judgement
        // Presenterからの伝達で、UI更新
        // 自分と相手の手札を見せあい、役がわかるようにしたい
        /* TODO:-
             ・cpuCardCVのUIを更新し、カードの柄が見えるようにする
             ・相手と自分の役がわかるように、Handも一緒に伝達する ->テスト OK
         */
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
