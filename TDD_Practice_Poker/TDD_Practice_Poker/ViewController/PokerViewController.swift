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
    var removeCellHashValues = RemoveCellHashValuesProperty()
    var localObject:String = ""
    
    @IBOutlet weak var cpuCardCollectionView: UICollectionView!
    @IBOutlet weak var throwoutCardCollectionView: UICollectionView!
    @IBOutlet weak var playerCardCollectionView: UICollectionView!
    @IBOutlet weak var changeCardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.build()
        self.setupCollectionViews()
        self.changeCardButton.addTarget(self,action: #selector(self.tappedChangeCardBtn(_ :)),for: .touchUpInside)
//        self.changeCardButton.isHidden = true
    }
    
    @objc func tappedChangeCardBtn(_ sender: UIButton){
        
//        pokerPresenter?.changeCardButtonStatus()
        updateCardUI(sourceIndexPath: nil, destinationIndexPath: nil)
    }
    
    func updateChangeCardButtonUI(_ changeState: Bool) {
        
        self.playerCardCollectionView.dragInteractionEnabled = changeState
        
        switch  changeState {
        case true:
            // カード選択状態を許可する
            // ボタン表記を「OK」に変更
            print("ok")
            // MARK:- CollectionViewCellが選択状態のときに有効となる


                // スタブ OK
                //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                //                self.pokerPresenter?.addCard(playerType: .me)
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
}

