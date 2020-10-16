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
        self.openAllCPUCards(otherHand: otherHand)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.animationView?.showJudge(judgement:judgement,myHand:myHand,otherHand:otherHand)
        }
    }
    
    func updateGameStateUI(_ gameSide:GameSide) {
        print("gamestateを更新")
        // Presenterからの伝達で、UI更新
        changePlayerCollectionViewDragEnable(nextGameSide: gameSide)
        changeCircleMenuButtonIsHidden(nextGameSide: gameSide)
        animationView?.showTurnOverAnimationView(nextGameSide:gameSide)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // CPUの処理を開始する.
            if gameSide == .playerType(.other){
                self.pokerPresenter?.callCPU()
            } else {
                print(self.pokerPresenter?.pokerInteractor.handStatus.otherPlayerHand.cards)
                print(self.pokerPresenter?.pokerInteractor.handStatus.otherPlayerHand.handState)
            }
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
