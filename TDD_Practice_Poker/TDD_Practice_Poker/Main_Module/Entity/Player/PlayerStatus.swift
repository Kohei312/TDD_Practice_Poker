//
//  PlayerList.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/07.
//

import Foundation

// 仮実装OK
final class PlayerStatus{
    
    var players:[Player] = []
    var interactorInputProtocol:InteractorInputProtocol?
    
    subscript(playerType:PlayerType)->Player{
        get{
            return players.filter({$0.playerType == playerType}).last!
        }
        set(newValue){
            if let player = players.filter({$0.playerType == playerType}).last{
                for (index,p) in players.enumerated() {
                    if p.playerType == player.playerType{
                        players.remove(at: index)
                        players.insert(newValue, at: index)
                    }
                }
            }
        }
    }
    
    init(){
        let player_me = Player(playerType:.me)
        let player_other = Player(playerType: .other)
        players = [player_me,player_other]
    }

    
    func changePlayerStatement(_ playerType:PlayerType, playerStatement:PlayerStatement){

        self[playerType].playerStatement = playerStatement

    }
    
    func decrementChangeCount(_ playerType:PlayerType){
        
        self[playerType].changeCount -= 1
        
        interactorInputProtocol?.checkGameStatement(playerType)
        
    }
    
    func callReadyButtle(_ playerType:PlayerType){
        
        self[playerType].playerStatement = .isReadyButtle
        self[playerType].changeCount = 0
    }
}
