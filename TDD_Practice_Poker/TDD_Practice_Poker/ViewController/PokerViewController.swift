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
        self.playerCardCollectionView
        for i in 0...2{
            pokerPresenter?.addCard(playerType: .me, takeNumber: 1, willRemoveIndex: IndexPath())
            
            // TODO:- rowは、playerCardsの最後尾に指定
            removedIndexPath = IndexPath(row:  i, section: 0)
            self.playerCardCollectionView.performBatchUpdates({
                self.playerCardCollectionView.insertItems(at: [removedIndexPath])
            })
        }
    }
    
    func updateUI(judgement:Judgement) {
        print("presenterから呼ばれる")
        self.result = judgement
        
        // Presenterからの伝達で、UI更新
    }
    


}

