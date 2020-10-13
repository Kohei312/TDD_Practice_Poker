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
    var removeIndexPath = RemoveIndexPathProperty()
    
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
        
        pokerPresenter?.changeCardButtonStatus()

    }
    
    func updateChangeCardButtonUI(_ changeState: Bool) {
        
        self.playerCardCollectionView.allowsMultipleSelection = changeState
        
        switch  changeState {
        case true:
            // カード選択状態を許可する
            // ボタン表記を「OK」に変更
            print("ok")
            // MARK:- CollectionViewCellが選択状態のときに有効となる
            // if removeIndexPath.removeIndexPaths != []{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.pokerPresenter?.addCard(playerType: .me)
            }
//            }
        case false:
            // カード選択状態を不許可にする
            // ボタン表記を「交換する」に変更
            print("交換する")
        }
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
    
    #warning("直列処理でprotocolが呼ばれると、pokerPresenterへの多重アクセスとみなされクラッシュする点に注意")
    func updatePlayerUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
//            guard let indexPath = self.removeIndexPath.removeIndexPaths.last else {return}
//            self.pokerPresenter?.throwCard(playerType: .me, takeNumber: 1,willRemoveIndexPath: indexPath)
//
//            // indexPathを作成して返却する
//            self.playerCardCollectionView.performBatchUpdates({
//                self.playerCardCollectionView.deleteItems(at: [indexPath])
//            })
//
//            if let itemitem = self.pokerPresenter?.pokerInteractor.handStatus.cardDeck.appearedCards.count{
//                self.throwoutCardCollectionView.performBatchUpdates({
//                    self.throwoutCardCollectionView.insertItems(at: [IndexPath(row:  itemitem - 1, section: 0)])
//                })
//            }
            
        self.playerCardCollectionView.insertItems(at: [IndexPath(row: self.playerCardCollectionView.visibleCells.count - 1, section: 0)])
                
            
   
//            let updateIndexes = self.playerCardCollectionView.indexPathsForVisibleItems
//            self.playerCardCollectionView.reloadItems(at: updateIndexes)
        }
    }
}

