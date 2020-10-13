//
//  PokerPresenter.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/08.
//

import Foundation

protocol PokerPresenterOutputProtocol{
    func updateJudgementUI(judgement:Judgement)
    func updateGameStateUI()
    func updatePlayerUI()
}

extension PokerPresenter:InteractorOutputProtocol{
    mutating func callUpdatePlayerUI() {
        pokerPresenterOutputProtocol?.updatePlayerUI()
    }
    
    
    mutating func callPresenter(_ gameSide:GameSide,judgeStatus:Judgement?) {
        print("各UIパーツに状態変更を指示")
        if let judge = judgeStatus{
            print("結果は :",judge)
            pokerPresenterOutputProtocol?.updateJudgementUI(judgement: judge)
        }
    }
}

public struct PokerPresenter{
    

    var pokerInteractor:PokerInteractor
    var pokerPresenterOutputProtocol:PokerPresenterOutputProtocol?
    var result:Judgement = .draw
    var removeIndexPath:RemoveIndexPathProperty
    
    init(pokerInteractor:PokerInteractor,removeIndexPath:RemoveIndexPathProperty){
        self.pokerInteractor = pokerInteractor
        self.removeIndexPath = removeIndexPath
    }
    
    // ViewControllerからDI
    mutating func inject(pokerPresenterOutputProtocol:PokerPresenterOutputProtocol){
        self.pokerPresenterOutputProtocol = pokerPresenterOutputProtocol
    }
    
    // MARK:- ViewControllerからの入力を受け,PokerInteractorに伝達
    mutating func changeCardIndex(playerType:PlayerType,willMoveIndexPath:IndexPath,willReplaceIndexPath:IndexPath){
        let willMoveIndex = willMoveIndexPath.row
        let willReplaceIndex = willReplaceIndexPath.row
        pokerInteractor.changeCardIndex(playerType:playerType,willMoveIndex:willMoveIndex,willReplaceIndex:willReplaceIndex)
    }
    
    mutating func changeCard(playerType:PlayerType,takeNumber:Int,willRemoveIndexPath:IndexPath){
        let willRemoveIndex = willRemoveIndexPath.row
        pokerInteractor.choseChange(playerType, takeNumber: takeNumber, willRemoveIndex:willRemoveIndex)
    }
    
    mutating func addCard(playerType:PlayerType){
//        let takeNumber = removeIndexPath.removeIndexPaths.count
        let takeNumber = 1
        pokerInteractor.addCard(playerType:playerType,takeNumber:takeNumber)
        
        //MARK:- UI更新をコール
    }
    
    mutating func finishChangeCard(_ playerType:PlayerType){
        pokerInteractor.decrementChangeCounter(playerType)
    }
}
