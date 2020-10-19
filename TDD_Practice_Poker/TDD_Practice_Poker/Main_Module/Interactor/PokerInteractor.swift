//
//  PokerInteractor.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/08.
//

import Foundation

// MARK:- InteractorInputProtocol
extension PokerInteractor:InteractorInputProtocol{
    func completeCPUTurn(playerStatement:PlayerStatement) {

        if playerStatement == .isReadyButtle{
            self.isReadyButtle(.other)
        } else {
            self.chosePass(.other)
        }
    }
    
    func notify(_ gameSide:GameSide,judgement:Judgement?) {
        switch gameSide{
        case .playerType(.me),.playerType(.other),.beforeJudgement:
            interactorOutputProtocol?.callPresenter(gameSide,judgement:nil,myHand:nil,otherHand:nil)
        case .result:
            let myHand = handStatus.myPlayerHand
            let otherHand = handStatus.otherPlayerHand
            interactorOutputProtocol?.callPresenter(gameSide,judgement:judgement,myHand:myHand,otherHand:otherHand)
        }
    }
    
    func changePlayerStatement(_ playerType:PlayerType){
        checkCountState(playerType)
    }
}

// MARK:- Protocolの具体的な実装は,PokerInteractorProtocol.swiftに記載.
public struct PokerInteractor{
    // MARK:- Output先のprotocolをDI
    var interactorOutputProtocol:InteractorOutputProtocol?
    var handStatus:HandStatus
    var players:PlayerStatus
    var judgementStatus:JudgementStatus
    
    init(handStatus:HandStatus,playerStatus:PlayerStatus,judgementStatus:JudgementStatus){

        self.handStatus = handStatus
        self.players = playerStatus
        self.judgementStatus = judgementStatus
    }
    
    mutating func inject(interactorOutputProtocol:InteractorOutputProtocol){
        
        self.interactorOutputProtocol = interactorOutputProtocol

        players.interactorInputProtocol = self
        judgementStatus.interactorInputProtocol = self
        handStatus.interactorInputProtocol = self
    }
}

extension PokerInteractor{
    // MARK:- HandStatus
    // カードを交換したとき
    mutating func throwCard(_ playerType:PlayerType,takeNumber:Int,willRemoveIndex:Int){
        changeCard(playerType:playerType,takeNumber:takeNumber,willRemoveIndex: willRemoveIndex)
    }
    
    mutating func changeCard(playerType:PlayerType,takeNumber:Int,willRemoveIndex:Int){
        handStatus.changeCard(playerType: playerType, takeNumber: takeNumber, willRemoveIndex:willRemoveIndex)
    }
    
    mutating func changeCardIndex(playerType:PlayerType,willMoveIndex:Int,willReplaceIndex:Int){
        handStatus.changeCardIndex(playerType:playerType,willMoveIndex:willMoveIndex,willReplaceIndex:willReplaceIndex)
    }
    
    mutating func startCPUTurn(){
        
        if players.player_other.changeCount == 0{
            isReadyButtle(.other)
        } else {
            handStatus.checkCPUCard()
        }
    }
    
    // MARK:- JudgementStatus
    func judge(){
        judgementStatus.judge(handStatus: handStatus)
    }
    
    // 攻守交代ボタンを押したとき
    func chosePass(_ playerType:PlayerType){
        players.decrementChangeCount(playerType)
    }
    
    
    func checkCountState(_ playerType:PlayerType){

        
        switch playerType{
        case .me:
            if players.player_me.changeCount <= 0 &&
                players.player_me.playerStatement != .isReadyButtle{
                isReadyButtle(playerType)
            } else {
                changeGameStatement(playerType)
            }
        case .other:
            if players.player_other.changeCount <= 0 &&
                players.player_other.playerStatement != .isReadyButtle {
                isReadyButtle(playerType)
            } else {
                changeGameStatement(playerType)
            }

        }
    }
    
    
    
    func isReadyButtle(_ playerType:PlayerType){

        players.callReadyButtle(playerType)

    }
    
    
    func changeGameStatement(_ playerType:PlayerType){
        
        if players.player_me.playerStatement == .isReadyButtle &&
            players.player_other.playerStatement == .isReadyButtle{
            
            
            notify(.beforeJudgement, judgement: nil)
        
        
        } else if players.player_me.playerStatement == .isReadyButtle &&
                    players.player_other.playerStatement != .isReadyButtle{
            notify(.playerType(.other), judgement: nil)

                
        } else if players.player_me.playerStatement != .isReadyButtle &&
                    players.player_other.playerStatement == .isReadyButtle{
            notify(.playerType(.me), judgement: nil)

                
        } else {
            changePlayerStatement(playerType, playerStatement: .waiting)
        }
    }
    
    // MARK:- PlayerState
    func changePlayerStatement(_ playerType:PlayerType, playerStatement:PlayerStatement){
        switch playerType{
        case .me:
            players.player_me.playerStatement = playerStatement
            notify(.playerType(.other), judgement: nil)

        case .other:

            players.player_other.playerStatement = playerStatement
            notify(.playerType(.me), judgement: nil)

        }
    }
}
