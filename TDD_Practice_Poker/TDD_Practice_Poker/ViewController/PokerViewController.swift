//
//  PokerViewController.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/03.
//

import UIKit
import CircleMenu

class PokerViewController: UIViewController,PokerPresenterOutputProtocol,RandomNumberProtocol{

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
    var animationView:GameStateAnimationView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.build()
        
    }

    
    func updateJudgementUI(judgement: Judgement, myHand: Hand, otherHand: Hand) {
        // スタブ OK
        print("presenterから呼ばれる")
        self.result = judgement
        // CPUのCollectionViewの更新を忘れずに
        animationView?.showJudge(itemFrame:.ResultLabel,judgement:judgement,myHand:myHand,otherHand:otherHand)
        
//        animationView?.setupItemLabelText(itemFrame:.ResultLabel,result:.showJudge,judgement:judgement,hand:nil)
//        animationView?.setupItemLabelText(itemFrame:.MyHandStateLabel,result:.showJudge,judgement:nil,hand:myHand)
//        animationView?.setupItemLabelText(itemFrame:.CPUHandStateLabel,result:.showJudge,judgement:nil,hand:otherHand)
//        animationView?.shouldAppearAnimationView(true)
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
       
        view.isHidden = false
    }
    
    func changeCircleMenuButtonIsHidden(){
        guard let menuButton = circleMenuButton else {return}
        circleMenuButton?.isHidden = menuButton.isHidden ? false : true
    }
}
