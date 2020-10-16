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
        if gameSide == .playerType(.other){
//            showCPUAnimation()
            // Presenterからの伝達で、UI更新
            changePlayerCollectionViewDragEnable(nextGameSide: gameSide)
            changeCircleMenuButtonIsHidden(nextGameSide: gameSide)
            animationView?.showTurnOverAnimationView(nextGameSide:gameSide)
            showCPUAnimation()

        } else if gameSide == .playerType(.me) {
            // Presenterからの伝達で、UI更新
            changePlayerCollectionViewDragEnable(nextGameSide: gameSide)
            changeCircleMenuButtonIsHidden(nextGameSide: gameSide)
            animationView?.showTurnOverAnimationView(nextGameSide:gameSide)
            
        }
    }
        
    func showCPUAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.changeCPUCard()
            self.pokerPresenter?.callCPU()
//            self.pokerPresenter?.finishCPUTurn()
        }
    }
}

extension PokerViewController{
    
    func changePlayerCollectionViewDragEnable(nextGameSide:GameSide){
        
        switch nextGameSide{
        
        case .playerType(.other),.result:
            playerCardCollectionView.dragInteractionEnabled = false
        case .playerType(.me):
            playerCardCollectionView.dragInteractionEnabled = true
        }
    }
    
    func changeCircleMenuButtonIsHidden(nextGameSide:GameSide){
        
        switch nextGameSide{
        
        case .playerType(.other),.result:
            circleMenuButton?.isHidden = true
        case .playerType(.me):
            circleMenuButton?.isHidden = false
        }
    }
}
