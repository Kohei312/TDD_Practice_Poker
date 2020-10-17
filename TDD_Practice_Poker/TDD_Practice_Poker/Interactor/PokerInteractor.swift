//
//  PokerInteractor.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/08.
//

import Foundation

// MARK:- InteractorInputProtocol
extension PokerInteractor:InteractorInputProtocol{
    mutating func completeCPUTurn() {
//        interactorOutputProtocol?.callUpdateCPU_UI()
        self.chosePass(.other)
    }
    
    mutating func notify(_ gameSide:GameSide,judgeStatus:Judgement?) {
        switch gameSide{
        case .playerType(.me),.playerType(.other),.beforeJudgement:
            interactorOutputProtocol?.callPresenter(gameSide,judgeStatus:nil,myHand:nil,otherHand:nil)
        case .result:
            let myHand = handStatus.myPlayerHand
            let otherHand = handStatus.otherPlayerHand
            interactorOutputProtocol?.callPresenter(gameSide,judgeStatus:judgeStatus,myHand:myHand,otherHand:otherHand)
        }
    }
}

// MARK:- Protocolの具体的な実装は,PokerInteractorProtocol.swiftに記載.
struct PokerInteractor{
    // MARK:- Output先のprotocolをDI
    var interactorOutputProtocol:InteractorOutputProtocol?
    var handStatus:HandStatus
    var gameFieldStatus:GameFieldStatus
    var player_me:PlayerStatus
    var player_other:PlayerStatus
    var judgementStatus:JudgementStatus
    
    init(handStatus:HandStatus, gameFieldStatus:GameFieldStatus,playerStatus_me:PlayerStatus,playerStatus_other:PlayerStatus, judgementStatus:JudgementStatus){

        self.handStatus = handStatus
        self.gameFieldStatus = gameFieldStatus
        self.player_me = playerStatus_me
        self.player_other = playerStatus_other
        self.judgementStatus = judgementStatus
    }
    
    mutating func inject(interactorOutputProtocol:InteractorOutputProtocol){
        
        self.interactorOutputProtocol = interactorOutputProtocol

        gameFieldStatus.interactorInputProtocol = self
        player_me.interactorInputProtocol = self
        player_other.interactorInputProtocol = self
        judgementStatus.interactorInputProtocol = self
        handStatus.interactorInputProtocol = self
    }
}

extension PokerInteractor{
    // MARK:- HandStatus
    mutating func changeCard(playerType:PlayerType,takeNumber:Int,willRemoveIndex:Int){
        handStatus.changeCard(playerType: playerType, takeNumber: takeNumber, willRemoveIndex:willRemoveIndex)
    }
    
    mutating func changeCardIndex(playerType:PlayerType,willMoveIndex:Int,willReplaceIndex:Int){
        handStatus.changeCardIndex(playerType:playerType,willMoveIndex:willMoveIndex,willReplaceIndex:willReplaceIndex)
    }
    
    mutating func startCPUTurn(){
        handStatus.checkCPUCard()
    }
    
    // MARK:- JudgementStatus
    mutating func judge(){
        judgementStatus.judge(handStatus: handStatus)
    }
    
    // MARK:- GameFieldState
    // 攻守交代
    mutating func changeGameSide(nextGameSide:GameSide){
        gameFieldStatus.gameSide = nextGameSide
    }
   
    // 攻守交代ボタンを押したとき
    mutating func chosePass(_ playerType:PlayerType){
        switch playerType{
        case .me:
            player_me.player.playerStatement = .action(.pass)
        case .other:
            player_other.player.playerStatement = .action(.pass)
        }
        // カード交換回数デクリメント
        decrementChangeCounter(playerType)
    }
    
    // カードを交換したとき
    mutating func throwCard(_ playerType:PlayerType,takeNumber:Int,willRemoveIndex:Int){
        
        switch playerType{
        case .me:
            player_me.player.playerStatement = .action(.change)
            changeCard(playerType:playerType,takeNumber:takeNumber,willRemoveIndex: willRemoveIndex)
        case .other:
            player_other.player.playerStatement = .action(.change)
            changeCard(playerType:playerType,takeNumber:takeNumber,willRemoveIndex: willRemoveIndex)
        }
    }
    
    
    
    // MARK:- PlayerState
    mutating func changePlayerStatement(_ playerType:PlayerType, playerStatement:PlayerStatement){
        switch playerType{
        case .me:
            player_me.changePlayerStatement(playerStatement)
            
            player_other.changePlayerStatement(.thinking)
            changeGameSide(nextGameSide:.playerType(.other))
        case .other:
            player_other.changePlayerStatement(playerStatement)
            
            player_me.changePlayerStatement(.thinking)
            changeGameSide(nextGameSide:.playerType(.me))
        }
    }


    mutating func decrementChangeCounter(_ playerType:PlayerType){
        var count = 0
        switch playerType{
        case .me:
            count = player_me.decrementChangeCount()
        case .other:
            count = player_other.decrementChangeCount()
        }
        
        if count == 0{
            isReadyButtle(playerType)
        } else {
            changeGameStatement(playerType,noChangeCount: false)
        }

    }
    
    mutating func isReadyButtle(_ playerType:PlayerType){
        //        if tapped ButtleBtn == true ||
        //        changeNumberOfCard == 0{
        switch playerType{
        case .me:
            player_me.callReadyButtle()
        case .other:
            player_other.callReadyButtle()
        }
        

        changeGameStatement(playerType,noChangeCount: true)
    }
    
    mutating func changeGameStatement(_ playerType:PlayerType, noChangeCount:Bool){

        #warning("修正をわすれないように")
//        &&
//            player_other.player.playerStatement == .isReadyButtle
        if player_me.player.playerStatement == .isReadyButtle {
            
            if gameFieldStatus.gameSide == .beforeJudgement{
                judge()
            } else {
                changeGameSide(nextGameSide:.beforeJudgement)
            }
        
        } else if player_me.player.playerStatement == .isReadyButtle &&
                    player_other.player.playerStatement != .isReadyButtle{
              
            changeGameSide(nextGameSide:.playerType(.other))
                
        } else if player_me.player.playerStatement != .isReadyButtle &&
                    player_other.player.playerStatement == .isReadyButtle{
              
            changeGameSide(nextGameSide:.playerType(.me))
                
        } else {
            
            changePlayerStatement(playerType, playerStatement: .waiting)
        }
    }
}

