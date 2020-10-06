//
//  PlayerStatus.swift
//  TDD_Practice_Poker
//
//  Created by kohei yoshida on 2020/10/04.
//

import Foundation

enum PlayerState{
    case inPlaying
    case win
    case draw
    case lose
}

enum RankStrength:Comparable,CaseIterable{
    case Strongest
    case Stronger
    case Middle
    case Weaker
    case Weakest
}

protocol PlayerStatusProtocol{
    func compareCards(_ myHandStatus:HandStatus, otherHandStatus:HandStatus)->PlayerState
    func compareCardRanks(myCardRank:Card.Rank?,otherCardRank:Card.Rank?)->PlayerState
    func checkLestRank(_ lestRanks:[Card.Rank],returnStrength:RankStrength)->Card.Rank
    func checkStraightStrongRank(_ handStatus:HandStatus)->Card.Rank
}

// 仮実装OK
struct PlayerStatus:PlayerStatusProtocol{
    
//    var players:[Player]
//    var myPlayer:[Player]{
//        players.filter({$0.playerType == PlayerType.me})
//    }
//    var otherPlayers:[Player]{
//        players.filter({$0.playerType == PlayerType.other})
//    }
    
    var myPlayer:Player
    var otherPlayers:[Player]
    
    var PlayerState:PlayerState{
        
        let myHandStatus = myPlayer.handStatus
        
        var playerState:PlayerState = .draw
        for otherPlayer in otherPlayers{
            
            let otherHandStatus = otherPlayer.handStatus
            
            if myHandStatus.handState < otherHandStatus.handState{
                
                playerState = .lose
                
            } else if myHandStatus.handState > otherHandStatus.handState{
               
                playerState = .win
                
            } else if myHandStatus.handState == otherHandStatus.handState{
                
                playerState = self.compareCards(myHandStatus,otherHandStatus:otherHandStatus)
            }
        }
        
        return playerState
    }
}
