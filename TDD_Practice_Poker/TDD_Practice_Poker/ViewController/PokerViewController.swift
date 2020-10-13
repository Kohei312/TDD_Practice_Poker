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
    var removedIndexPath = IndexPath()
    
    @IBOutlet weak var cpuCardCollectionView: UICollectionView!
    @IBOutlet weak var throwoutCardCollectionView: UICollectionView!
    @IBOutlet weak var playerCardCollectionView: UICollectionView!
    @IBOutlet weak var changeCardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.build()
        self.setupCollectionViews()
        self.changeCardButton.addTarget(self,action: #selector(self.tappedChangeCardBtn(_ :)),for: .touchUpInside)
    }
    
    @objc func tappedChangeCardBtn(_ sender: UIButton){
        
        pokerPresenter?.addCard(playerType: .me)
        

                // スタブ OK
//        for i in 0..<3{
//            pokerPresenter?.addCard(playerType: .me)
//
//            // TODO:- rowは、playerCardsの最後尾に指定
//            removedIndexPath = IndexPath(row: 4 + i, section: 0)
//            self.playerCardCollectionView.performBatchUpdates({
//                self.playerCardCollectionView.insertItems(at: [removedIndexPath])
//            })
//        }
    }
    
    func updateJudgementUI(judgement:Judgement) {
        print("presenterから呼ばれる")
        self.result = judgement
        
        // Presenterからの伝達で、UI更新
    }
    
    func updateGameStateUI() {
        print("gamestateを更新")
        // Presenterからの伝達で、UI更新
    }
    
    func updatePlayerUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            guard let i = self.pokerPresenter?.removeIndexPath.removeIndexPaths else {return}
            self.playerCardCollectionView.performBatchUpdates({
                    self.playerCardCollectionView.insertItems(at: i)
                
            })
        }
    }
}

