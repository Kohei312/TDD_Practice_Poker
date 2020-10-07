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


struct Player{
    
    var playerType:PlayerType
    var hand:Hand
    /*
     // ToolBarの「勝負する」ボタンを押す, または
     // 3回交換したら (交換カウントが0になったら) 変更される
     // ↑を管理するクラスのProtocolをそれぞれココにDIし、UI更新を図る
     var readyButtle:ReadyButtle = .none
     
     func isReadyButtle(){
        if tapped ButtleBtn == true ||
        changeNumberOfCard == 0{
            readyButtle = .readyButtle
     }
     
    */
    
    
}
