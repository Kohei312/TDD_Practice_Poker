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
    
    mutating func changeGameSide(){
        gameFieldStatus.gameSide = .me
    }
    
    mutating func changeToJudgementStaus(){
        gameFieldStatus.gameSide = .judging
        gameFieldStatus.gameField = .readyStartJudgement
    }
    
    
    
    // MARK:- PlayerState　ひとまずベタ書き
    var player_me = PlayerStatus(playerType: .me)
    var player_other = PlayerStatus(playerType: .other)
    
    // カードを交換した回数を更新するメソッド欲しい
    
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
        isStartJudgement(playerType)
    }
    
    mutating func isStartJudgement(_ playerType:PlayerType){
        if player_me.player.playerStatement == .isReadyButtle &&
            player_other.player.playerStatement == .isReadyButtle{
            
            changeToJudgementStaus()
        
        }

    }
}
