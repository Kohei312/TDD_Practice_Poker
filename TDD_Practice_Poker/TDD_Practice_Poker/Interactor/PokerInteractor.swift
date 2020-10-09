//
//  PokerInteractor.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/08.
//

import Foundation

struct PokerInteractor{
    
    #warning("ViewController起動時にまとめてDIする")
    // MARK:- Output先のprotocolをDI
//    var presenterOutputProtocol:PokerPresenterOutputProtocol?
//    func inject(presenterOutputProtocol:PokerPresenterOutputProtocol){
//       self.presenterOutputProtocol = presenterOutputProtocol
//    }
//
//
    
    // MARK:- HandStatus
    var handStatus = HandStatus()
    // var handStatus = HandStatus(output:JudgementStatusProtocol)
    
    // Hand内にあるカードのSuit・RankをPresenterに返したい（特に初期化時）
    
    // スタブ OK
    mutating func drawCard(takeNumber:Int,playerType:PlayerType,removeCardIndex:[Int]){
        handStatus.drawCard(takeNumber: takeNumber, playerType: playerType, removeCardIndex: removeCardIndex)
    }
    
    // MARK:- GameFieldState
    // PlayerTypeによってUI操作をコントロールする
    var gameFieldStatus = GameFieldStatus()
    
    mutating func changeGameSide(nextGameSide:GameSide){
        gameFieldStatus.gameSide = nextGameSide
    }
    
    mutating func changeToJudgementStatus(){
        gameFieldStatus.gameSide = .judging
        gameFieldStatus.gameField = .readyStartJudgement
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
    
    
    
    // MARK:- PlayerState　ひとまずベタ書き
    var player_me = PlayerStatus(playerType: .me)
    var player_other = PlayerStatus(playerType: .other)
    
    mutating func changePlayerStatement(_ playerType:PlayerType, playerStatement:PlayerStatement){
        switch playerType{
        case .me:
            player_me.changePlayerStatement(playerStatement)
            
            player_other.changePlayerStatement(.thinking)
            changeGameSide(nextGameSide:.other)
        case .other:
            player_other.changePlayerStatement(playerStatement)
            
            player_me.changePlayerStatement(.thinking)
            changeGameSide(nextGameSide:.me)
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
            
            changeToJudgementStatus()
        
        } else {
            
            changePlayerStatement(playerType, playerStatement: .waiting)
        }

    }
}
