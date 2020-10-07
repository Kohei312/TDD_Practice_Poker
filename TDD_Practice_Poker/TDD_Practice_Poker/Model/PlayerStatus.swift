//
//  PlayerList.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

// 仮実装OK
struct PlayerStatus{
    
    var player_me:Player
    var player_other:Player
    init(){
        self.player_me = Player(playerType: .me)
        self.player_other = Player(playerType: .other)
       
    }
    
    
    #warning("最初にまとめてDIする")
//    var dependency:GameFieldStatusProtocol?
//    init(dependency:GameFieldStatusProtocol){
//        self.dependency = dependency
//        self.player_me = Player(playerType: .me)
//        self.player_other = Player(playerType: .other)
//    }
    
    mutating func isReadyButtle(_ playerType:PlayerType){
        //        if tapped ButtleBtn == true ||
        //        changeNumberOfCard == 0{
        switch playerType{
        case .me:
            player_me.readyButtle = .readyButtle
        case .other:
            player_other.readyButtle = .readyButtle
        }

        #warning("ここでGameFieldStatusProtocol.willChangeGameFieldStatus()をコール")
        if player_me.readyButtle == .readyButtle && player_other.readyButtle == .readyButtle{
            //        GameFieldStatusProtocol?.willChangeGameFieldStatus()
            // 仮実装OK
//            print("いざ、尋常に勝負!!")
        }

        //        }
    }
}
