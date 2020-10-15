//
//  PokerPresenter.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/08.
//

import Foundation



extension PokerPresenter:InteractorOutputProtocol{
    func callUpdatePlayerUI() {
        //        pokerPresenterOutputProtocol?.updatePlayerUI()
    }

    mutating func callPresenter(_ gameSide:GameSide,judgeStatus:Judgement?,myHand:Hand?,otherHand:Hand?) {
        print("各UIパーツに状態変更を指示 :",gameSide)
        switch gameSide{
        case .playerType(.me):
            pokerPresenterOutputProtocol?.updateGameStateUI()
        case .playerType(.other):
            pokerPresenterOutputProtocol?.updateGameStateUI()
        case .result:
            if let judge = judgeStatus,let myHand = myHand,let otherHand = otherHand{
                print("結果は :",judge)
                print("決まり手は :",myHand.handState)
                print("相手の決まり手は :",otherHand.handState)
                pokerPresenterOutputProtocol?.updateJudgementUI(judgement: judge,myHand: myHand,otherHand: otherHand)
            }
        }
    }
}

public struct PokerPresenter{
    
    
    var pokerInteractor:PokerInteractor
    var pokerPresenterOutputProtocol:PokerPresenterOutputProtocol?
    var result:Judgement = .draw
    
    init(pokerInteractor:PokerInteractor){
        self.pokerInteractor = pokerInteractor
        //        self.removeIndexPath = removeIndexPath
    }
    
    // ViewControllerからDI
    mutating func inject(pokerPresenterOutputProtocol:PokerPresenterOutputProtocol){
        self.pokerPresenterOutputProtocol = pokerPresenterOutputProtocol
    }
}

extension PokerPresenter{    
    // MARK:- ViewControllerからの入力を受け,PokerInteractorに伝達
    mutating func changeCardIndex(playerType:PlayerType,willMoveIndexPath:IndexPath,willReplaceIndexPath:IndexPath){
        let willMoveIndex = willMoveIndexPath.row
        let willReplaceIndex = willReplaceIndexPath.row
        pokerInteractor.changeCardIndex(playerType:playerType,willMoveIndex:willMoveIndex,willReplaceIndex:willReplaceIndex)
    }
    
    mutating func changeCard(playerType:PlayerType,takeNumber:Int,willRemoveIndexPath:IndexPath){
        let willRemoveIndex = willRemoveIndexPath.row
        pokerInteractor.throwCard(playerType, takeNumber: takeNumber, willRemoveIndex:willRemoveIndex)
        
    }
    
    mutating func addCard(playerType:PlayerType){
        //        let takeNumber = removeIndexPath.removeIndexPaths.count
        let takeNumber = 1
        pokerInteractor.addCard(playerType:playerType,takeNumber:takeNumber)
        //MARK:- UI更新をコール
    }
    
    mutating func tappedTurnoverBtn(_ playerType:PlayerType){
        pokerInteractor.decrementChangeCounter(playerType)
    }
    
    mutating func tappedBattleBtn(_ playerType:PlayerType){
        pokerInteractor.isReadyButtle(playerType)
    }
}
