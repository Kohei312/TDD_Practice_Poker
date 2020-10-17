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
    
    // MARK:- PlayerCollectionViewの制御プロパティ
    var removeCellHashValues = RemoveCellHashValuesProperty()
    var moveCardStatuses = MoveCardStatusProperty()

    // MARK:- MenuButtonの制御プロパティ
    var circleMenuButton:CircleMenu?
    var circleMenuButtonProperty = CircleMenuButtonProperty()
    
    @IBOutlet weak var cpuCardCollectionView: UICollectionView!
    @IBOutlet weak var throwoutCardCollectionView: UICollectionView!
    @IBOutlet weak var playerCardCollectionView: UICollectionView!
    var animationView:GameStateAnimationView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.build()
    }

    
    func updateJudgementUI(judgement: Judgement, myHand: Hand, otherHand: Hand) {
        // スタブ OK
        print("presenterから呼ばれる")
        // CPUのCollectionViewの更新を忘れずに
        self.openAllCPUCards(otherHand: otherHand)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.animationView?.showJudge(judgement:judgement,myHand:myHand,otherHand:otherHand)
        }
    }
    
    func updateGameStateUI(_ gameSide:GameSide) {
        print("gamestateを更新 :",gameSide)
        circleMenuButtonProperty.gameSide = gameSide
        // CPUの処理を開始する.
        changePlayerCollectionViewDragEnable(nextGameSide: gameSide)
        changeCircleMenuButtonIsHidden(nextGameSide: gameSide)
        animationView?.showTurnOverAnimationView(nextGameSide:gameSide)

        switch gameSide{
        
        case .playerType(.other):
            showCPUAnimation()
        case .playerType(.me):
            break
        case .result:
           break
        case .beforeJudgement:
            showJudge()
        }
    }
        
    func showCPUAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.changeCPUCard()
            self.pokerPresenter?.callCPU()
        }
    }
    
    func showJudge(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.pokerPresenter?.callJudge()
        }
    }
}

extension PokerViewController{
    
    func changePlayerCollectionViewDragEnable(nextGameSide:GameSide){
        
        switch nextGameSide{
        
        case .playerType(.other), .beforeJudgement, .result:
            playerCardCollectionView.dragInteractionEnabled = false
        case .playerType(.me):
            playerCardCollectionView.dragInteractionEnabled = true
        }
    }
    
    func changeCircleMenuButtonIsHidden(nextGameSide:GameSide){
        
        switch nextGameSide{
        
        case .playerType(.other),.beforeJudgement:
            circleMenuButton?.isHidden = true
        case .playerType(.me):
            circleMenuButton?.isHidden = false
        case .result:
            circleMenuButton?.isHidden = false
        }
    }
}
