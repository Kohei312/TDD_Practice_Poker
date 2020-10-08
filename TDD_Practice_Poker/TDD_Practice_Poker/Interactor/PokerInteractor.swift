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
    #warning("PokerInteratorで初期化し、HandStatusの初期化引数に[Card]を入れる")
    var cardDeck = CardDeck()
    
    
    
    
    // MARK:- PlayerState　ひとまずベタ書き
    var player_me = PlayerStatus(playerType: .me)
    var player_other = PlayerStatus(playerType: .other)
    
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
        if player_me.player.isReadyButtle == .yup &&
            player_other.player.isReadyButtle == .yup{
            //        JudgementStatusProtocol?.judge()
            // 仮実装OK
//            print("いざ、尋常に勝負!!")
        }

        //        }
    }
}
