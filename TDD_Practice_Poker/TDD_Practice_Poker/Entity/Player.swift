//
//  Player.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/04.
//

import Foundation

#warning("ターンのコントロール時に必要")
enum PlayerType{
    case me
    case other
}
enum ReadyButtleState{
    case none
    case readyButtle
}

struct Player{
    
    var playerType:PlayerType
    var hand:Hand = Hand()
     // ToolBarの「勝負する」ボタンを押す, または
     // 3回交換したら (交換カウントが0になったら) 変更される
     // ↑を管理するクラスのProtocolをそれぞれココにDIし、UI更新を図る
    // 仮実装OK
    var readyButtle:ReadyButtleState = .none
    
    // ここにDIすると、エンティティ全体のバランスが崩れる.(弱い...)
    //    var dependency:GameFieldStatusProtocol?
    //    init(dependency:GameFieldStatusProtocol,playerType:PlayerType){
    //       self.dependency = dependency
    //       self.playerType = playerType
    //    }
     
    mutating func isReadyButtle(){
//        if tapped ButtleBtn == true ||
//        changeNumberOfCard == 0{
            readyButtle = .readyButtle
        #warning("ここでGameFieldStatusProtocol.willChangeGameFieldStatus()をコール")
//        }
    }
     
    
    
}
