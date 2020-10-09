//
//  PokerInteractor.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/08.
//

import Foundation

protocol InteractorInputProtocol{
    mutating func notify(_ gameSide:GameSide,judgeStatus:Judgement?)
}
protocol InteractorOutputProtocol{
    mutating func callPresenter(_ gameSide:GameSide,judgeStatus:Judgement?)
}


struct PokerInteractor:InteractorInputProtocol{
    
    mutating func notify(_ gameSide:GameSide,judgeStatus:Judgement?) {
        switch gameSide{
        case .playerType(.me),.playerType(.other):
            print("ここで他プレイヤーに移行、UI更新などを伝達")
            interactorOutputProtocol?.callPresenter(gameSide,judgeStatus: nil)
        case .result:
            interactorOutputProtocol?.callPresenter(gameSide,judgeStatus: judgeStatus)
        }
    }
    
//    func hoge(){
////        print(" judgementStatus.notifyJudgementResultProtocol :", judgementStatus.notifyJudgementResultProtocol!)
//        judge()
//    }
    
    #warning("ViewController起動時にまとめてDIする")
    // MARK:- Output先のprotocolをDI
    var interactorOutputProtocol:InteractorOutputProtocol?
    
    init(handStatus:HandStatus, gameFieldStatus:GameFieldStatus,playerStatus_me:PlayerStatus,playerStatus_other:PlayerStatus, judgementStatus:JudgementStatus){
       
        self.handStatus = handStatus
        self.gameFieldStatus = gameFieldStatus
        self.player_me = playerStatus_me
        self.player_other = playerStatus_other
        self.judgementStatus = judgementStatus
    }
    
    mutating func inject(interactorOutputProtocol:InteractorOutputProtocol){
        
        self.interactorOutputProtocol = interactorOutputProtocol
//        handStatus.interactorInputProtocol = self
        gameFieldStatus.interactorInputProtocol = self
        player_me.interactorInputProtocol = self
        player_other.interactorInputProtocol = self
        judgementStatus.interactorInputProtocol = self
    }
    // Hand内にあるカードのSuit・RankをPresenterに返したい（特に初期化時）
    // MARK:- HandStatus
    var handStatus:HandStatus
    // スタブ OK
    mutating func drawCard(playerType:PlayerType,takeNumber:Int,removeCardIndex:[Int]){
        handStatus.drawCard(playerType: playerType, takeNumber: takeNumber, removeCardIndex: removeCardIndex)
        decrementChangeCounter(playerType)
    }
    
    // MARK:- JudgementStatus
    var judgementStatus:JudgementStatus
    mutating func judge(){
        judgementStatus.judge(handStatus: handStatus)
    }
    
    
    
    // MARK:- GameFieldState
    // PlayerTypeによってUI操作をコントロールする
//    var gameFieldStatus = GameFieldStatus()
    var gameFieldStatus:GameFieldStatus
    
    mutating func changeGameSide(nextGameSide:GameSide){
        gameFieldStatus.gameSide = nextGameSide
    }
   
    
    // パスしたとき
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
    mutating func choseChange(_ playerType:PlayerType, takeNumber:Int,removeCardIndex:[Int]){
        switch playerType{
        case .me:
            player_me.player.playerStatement = .action(.change)
            drawCard(playerType:playerType,takeNumber:takeNumber,removeCardIndex:removeCardIndex)
        case .other:
            player_other.player.playerStatement = .action(.change)
            drawCard(playerType:playerType,takeNumber:takeNumber,removeCardIndex:removeCardIndex)
        }
        // カード交換回数デクリメント
        // ここでは呼ばず, CollectionViewのアニメーションが終了したあと,
        // Completionhandler内で decrementChangeCounter をコールする.
//        decrementChangeCounter(playerType)
    }
    
    
    
    // MARK:- PlayerState　ひとまずベタ書き
//    var player_me = PlayerStatus(playerType: .me)
//    var player_other = PlayerStatus(playerType: .other)
    var player_me:PlayerStatus
    var player_other:PlayerStatus
    
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

    
    // カードを交換した回数を更新するメソッド欲しい
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

        #warning("ここでGameFieldStatusProtocol.willChangeGameFieldStatus()をコール")
        changeGameStatement(playerType,noChangeCount: true)
    }
    
    mutating func changeGameStatement(_ playerType:PlayerType, noChangeCount:Bool){
        
        if player_me.player.playerStatement == .isReadyButtle &&
            player_other.player.playerStatement == .isReadyButtle{
            
            judge()
        
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
