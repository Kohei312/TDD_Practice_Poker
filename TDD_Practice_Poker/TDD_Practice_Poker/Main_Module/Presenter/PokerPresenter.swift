//
//  PokerPresenter.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/08.
//

import Foundation



extension PokerPresenter:InteractorOutputProtocol{

    func callPresenter(_ gameSide:GameSide,judgement:Judgement?,myHand:Hand?,otherHand:Hand?) {
        
        switch gameSide{
        case .playerType(.me),.playerType(.other),.beforeJudgement:
            pokerPresenterOutputProtocol?.updateGameStateUI(gameSide)
        case .result:
            if let judge = judgement, let myHand = myHand,let otherHand = otherHand{
                
                pokerPresenterOutputProtocol?.updateJudgementUI(judgement: judge,myHand: myHand,otherHand: otherHand)
            }
        }
    }
}

public struct PokerPresenter{
    
    var pokerRouter:PokerRouterWireframe
    var pokerInteractor:PokerInteractor
    var pokerPresenterOutputProtocol:PokerPresenterOutputProtocol?
    var result:Judgement = .draw
    
    init(pokerInteractor:PokerInteractor,pokerRouter:PokerRouterWireframe){
        self.pokerInteractor = pokerInteractor
        self.pokerRouter = pokerRouter
    }
    
    // ViewControllerからDI
    mutating func inject(pokerPresenterOutputProtocol:PokerPresenterOutputProtocol){
        self.pokerPresenterOutputProtocol = pokerPresenterOutputProtocol
    }
}

extension PokerPresenter{    
    // MARK:- ViewControllerからの入力を受け,PokerInteractorに伝達
    
    mutating func willChangeUserStatus(_ userAction:PlayerAction){
        switch userAction{
        case .tappedBattleBtn:
            pokerInteractor.isReadyButtle(.me)
        case .tappedRestartBtn:
            pokerRouter.dissmissFromPokerVC()
        case .tappedTurnoverBtn:
            pokerInteractor.chosePass(.me)
        }
    }
    
    mutating func changeCardIndex(playerType:PlayerType,willMoveIndexPath:IndexPath,willReplaceIndexPath:IndexPath){
        let willMoveIndex = willMoveIndexPath.row
        let willReplaceIndex = willReplaceIndexPath.row
        pokerInteractor.changeCardIndex(playerType:playerType,willMoveIndex:willMoveIndex,willReplaceIndex:willReplaceIndex)
    }
    
    mutating func changeCard(playerType:PlayerType,takeNumber:Int,willRemoveIndexPath:IndexPath){
        let willRemoveIndex = willRemoveIndexPath.row
        pokerInteractor.throwCard(playerType, takeNumber: takeNumber, willRemoveIndex:willRemoveIndex)
        
    }
    
    mutating func callCPU(){
        pokerInteractor.startCPUTurn()
    }
    
    mutating func callJudge(){
        pokerInteractor.judge()
    }
}
