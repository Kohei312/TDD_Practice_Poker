//
//  PokerInteractor.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/08.
//

import Foundation

// MARK:- InteractorInputProtocol
extension PokerInteractor:InteractorInputProtocol{
    mutating func completeCPUTurn(playerStatement:PlayerStatement) {

        if playerStatement == .isReadyButtle{
            self.isReadyButtle(.other)
        } else {
            self.chosePass(.other)
        }
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
    var players:PlayerStatus
//    var player_me:Player
//    var player_other:Player
    var judgementStatus:JudgementStatus
    
    init(handStatus:HandStatus, gameFieldStatus:GameFieldStatus,playerStatus:PlayerStatus,judgementStatus:JudgementStatus){

        self.handStatus = handStatus
        self.gameFieldStatus = gameFieldStatus
        self.players = playerStatus
//        self.player_me = Player(playerType: .me)
//        self.player_other = Player(playerType: .other)
        self.judgementStatus = judgementStatus
    }
    
    mutating func inject(interactorOutputProtocol:InteractorOutputProtocol){
        
        self.interactorOutputProtocol = interactorOutputProtocol

        gameFieldStatus.interactorInputProtocol = self
//        players.interactorInputProtocol = self
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
        
        if players.player_other.changeCount == 0{
            isReadyButtle(.other)
        } else {
            handStatus.checkCPUCard()
        }
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
            players.player_me.playerStatement = .action(.pass)
        case .other:
            players.player_other.playerStatement = .action(.pass)
        }
        // カード交換回数デクリメント
        decrementChangeCounter(playerType)
    }
    
    // カードを交換したとき
    mutating func throwCard(_ playerType:PlayerType,takeNumber:Int,willRemoveIndex:Int){
        
        switch playerType{
        case .me:
            players.player_me.playerStatement = .action(.change)
            changeCard(playerType:playerType,takeNumber:takeNumber,willRemoveIndex: willRemoveIndex)
        case .other:
            players.player_other.playerStatement = .action(.change)
            changeCard(playerType:playerType,takeNumber:takeNumber,willRemoveIndex: willRemoveIndex)
        }
    }
    
    mutating func decrementChangeCounter(_ playerType:PlayerType){
        var count = 0
        switch playerType{
        case .me:
            players.player_me.changeCount -= 1
            count = players.player_me.changeCount
        case .other:
            players.player_other.changeCount -= 1
            count =  players.player_other.changeCount
        }
        
        if count <= 0{
            isReadyButtle(playerType)
        } else {
            changeGameStatement(playerType,noChangeCount: false)
        }

    }
    
    mutating func isReadyButtle(_ playerType:PlayerType){

        switch playerType{
        case .me:
            players.player_me.playerStatement = .isReadyButtle
            players.player_me.changeCount = 0
        case .other:
            players.player_other.playerStatement = .isReadyButtle
            players.player_other.changeCount = 0
        }
        

        changeGameStatement(playerType,noChangeCount: true)
    }
    
    mutating func changeGameStatement(_ playerType:PlayerType, noChangeCount:Bool){
        
        if players.player_me.playerStatement == .isReadyButtle &&
            players.player_other.playerStatement == .isReadyButtle{
            
            if gameFieldStatus.gameSide == .beforeJudgement{
                judge()
            } else {
                changeGameSide(nextGameSide:.beforeJudgement)
            }
        
        } else if players.player_me.playerStatement == .isReadyButtle &&
                    players.player_other.playerStatement != .isReadyButtle{
              
            changeGameSide(nextGameSide:.playerType(.other))
                
        } else if players.player_me.playerStatement != .isReadyButtle &&
                    players.player_other.playerStatement == .isReadyButtle{
              
            changeGameSide(nextGameSide:.playerType(.me))
                
        } else {
            
            changePlayerStatement(playerType, playerStatement: .waiting)
        }
    }
    
    // MARK:- PlayerState
    mutating func changePlayerStatement(_ playerType:PlayerType, playerStatement:PlayerStatement){
        switch playerType{
        case .me:

            players.player_me.playerStatement = playerStatement
            changeGameSide(nextGameSide:.playerType(.other))
        case .other:

            players.player_other.playerStatement = playerStatement
//            player_me.changePlayerStatement(.thinking)
            changeGameSide(nextGameSide:.playerType(.me))
        }
    }

}

